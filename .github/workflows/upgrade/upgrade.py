#!/usr/bin/env python3
"""Run the existing Vivado migration sequence and retain a board test candidate.

Only the standard library is needed. Run in a disposable, clean checkout:
generated block_design/ and bitstream/ directories are replaced.
"""

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tarfile


def design_version(path):
    match = re.search(r'^set scripts_vivado_version\s+"?(\d{4}\.\d+)"?\s*$',
                      path.read_text(), re.MULTILINE)
    if not match:
        raise ValueError(f"Cannot determine source Vivado version: {path}")
    return match.group(1)


def settings_for(version):
    name = f"VIVADO_{version.replace('.', '_')}_SETTINGS"
    override = os.environ.get(name)
    if override:
        path = Path(override)
        if not path.is_file():
            raise ValueError(f"{name} does not name a settings64.sh file: {path}")
        return path.resolve()
    raise ValueError(f"Set {name} in the runner installation's .env and restart the runner.")


def tool_command(settings, arguments, cwd, log):
    # Pass all paths as positional arguments, never interpolate shell source.
    with log.open('w') as output:
        result = subprocess.run(
            ['bash', '-c', 'set -e; source "$1"; shift; exec "$@"',
             'vivado-ci', str(settings), *arguments],
            cwd=cwd, stdout=output, stderr=subprocess.STDOUT, check=False)
    if result.returncode:
        print(log.read_text()[-12000:], flush=True)
        raise RuntimeError(f"Command failed ({result.returncode}); see {log}")


def vivado(settings, arguments, cwd, log):
    tool_command(settings, ['vivado', *arguments], cwd, log)


def verify_tool(version, settings, cwd, reports):
    log = reports / f'vivado-{version}-version.log'
    vivado(settings, ['-version'], cwd, log)
    if not re.search(r'Vivado\s+v' + re.escape(version) + r'(?:\s|$)', log.read_text(), re.IGNORECASE):
        raise ValueError(f"Expected Vivado {version}; see {log}")


def stage(name, settings, board_dir, script, reports, design, label=None):
    reports = reports / (label or name)
    reports.mkdir()
    print(f'::group::{name}', flush=True)
    try:
        vivado(settings, ['-mode', 'batch', '-notrace', '-source', str(script),
                          '-log', str(reports / f'{name}.log'), '-nojournal',
                          '-tclargs', name, design, str(reports)],
               board_dir, reports / f'{name}-console.log')
    finally:
        print('::endgroup::', flush=True)


def package_candidate(repo, board, design, output, metadata):
    """Package tracked installation inputs plus only this board's fresh outputs."""
    archive = output / f'{design}_{board}_{metadata["commit"][:12]}.tar.gz'
    tracked = subprocess.check_output(['git', 'ls-files', '-z'], cwd=repo).decode().split('\0')
    selected = [p for p in tracked if p in ('setup.py', 'README.md', 'LICENSE')
                or p.startswith(design + '/')]
    # Exclude any previously packaged overlay; only fresh board outputs belong here.
    selected = [p for p in selected if Path(p).suffix not in ('.bit', '.hwh')]
    partial = archive.with_suffix('.partial')
    try:
        with tarfile.open(partial, 'w:gz') as tar:
            for relative in selected:
                tar.add(repo / relative, arcname=relative, recursive=False)
            for suffix in ('.bit', '.hwh'):
                relative = f'boards/{board}/{design}/bitstream/{design}{suffix}'
                tar.add(repo / relative, arcname=relative)
            tar.add(output / 'build.json', arcname='build.json')
        (output / 'SHA256SUMS').write_text(
            f'{hashlib.sha256(partial.read_bytes()).hexdigest()}  {archive.name}\n')
        partial.replace(archive)
    finally:
        partial.unlink(missing_ok=True)
    return archive


def run(args, repo):
    for value in (args.design, args.board):
        if not re.fullmatch(r'[A-Za-z0-9_]+', value):
            raise ValueError('Design and board must contain only letters, digits and underscores')
    board_dir = repo / 'boards' / args.board / args.design
    source_tcl = board_dir / f'{args.design}.tcl'
    checked_in_version = design_version(source_tcl)
    if args.build_only and args.upgrade_only:
        raise ValueError('Choose build-only or upgrade-only')
    if args.build_only:
        args.source_version = checked_in_version
        args.target_version = checked_in_version
    elif not (args.source_version and args.target_version):
        raise ValueError('Upgrade requires source and target Vivado versions')
    for value in (args.source_version, args.target_version):
        if not re.fullmatch(r'\d{4}\.\d+', value):
            raise ValueError('Vivado versions must have the form YYYY.N')
    if not re.fullmatch(r'\d+(?:\.\d+)+', args.pynq_version):
        raise ValueError('PYNQ version must be a numeric dotted version')
    output = repo / '.ci-artifacts' / args.board
    # Never publish an earlier successful candidate after a failed rerun.
    if output.exists():
        shutil.rmtree(output)
    reports = output / 'reports'
    reports.mkdir(parents=True)
    metadata = {
        'commit': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=repo, text=True).strip(),
        'board': args.board, 'design': args.design,
        'source_vivado': args.source_version, 'target_vivado': args.target_version,
        'target_pynq': args.pynq_version, 'hardware_test': 'not run',
        'status': 'preflight', 'run_url': os.environ.get('GITHUB_SERVER_URL', 'https://github.com')
        + '/' + os.environ.get('GITHUB_REPOSITORY', '') + '/actions/runs/'
        + os.environ.get('GITHUB_RUN_ID', ''),
    }
    original = None
    try:
        metadata['checked_in_vivado'] = checked_in_version
        if checked_in_version not in (args.source_version, args.target_version):
            raise ValueError(f'Design uses {checked_in_version}, not the declared source or target')
        # A real target build must not be silently substituted by the runner default.
        target = settings_for(args.target_version)
        verify_tool(args.target_version, target, board_dir, reports)
        source = target
        if checked_in_version != args.target_version:
            source = settings_for(args.source_version)
            verify_tool(args.source_version, source, board_dir, reports)
        if args.preflight_only:
            metadata['status'] = 'preflight passed; build not run'
            return
        if args.upgrade_only and checked_in_version == args.target_version:
            shutil.copy2(source_tcl, output / source_tcl.name)
            metadata['status'] = 'already at target version; no changes'
            return
        original = source_tcl.read_bytes()
        script = repo / '.github/workflows/upgrade/vivado.tcl'
        for name in (('block_design',) if args.upgrade_only else ('block_design', 'bitstream')):
            generated = board_dir / name
            if generated.exists():
                shutil.rmtree(generated)
        if checked_in_version != args.target_version:
            metadata['status'] = 'recreate source'
            stage('recreate', source, board_dir, script, reports, args.design, 'source-recreation')
            metadata['status'] = 'migrate'
            stage('migrate', target, board_dir, script, reports, args.design)
            if design_version(source_tcl) != args.target_version:
                raise RuntimeError('Exported Tcl does not declare the target Vivado version')
            shutil.copy2(source_tcl, output / source_tcl.name)
            patch = subprocess.check_output(['git', 'diff', '--binary', '--',
                                             str(source_tcl.relative_to(repo))], cwd=repo)
            (output / 'upgrade.patch').write_bytes(patch)
            shutil.rmtree(board_dir / 'block_design')
        metadata['generated_sources_need_commit'] = source_tcl.read_bytes() != original
        metadata['status'] = 'recreate target'
        stage('recreate', target, board_dir, script, reports, args.design, 'target-recreation')
        if args.upgrade_only:
            metadata['status'] = 'upgrade passed; commit generated Tcl'
            # Successful local upgrade leaves the verified Tcl in the checkout.
            original = None
            print(f'Upgraded: {source_tcl}\nReview and commit this file.', flush=True)
            return
        metadata['status'] = 'make all'
        # Verification created a project; make all must recreate it from exported Tcl.
        tool_command(target, ['make', 'clean'], board_dir, reports / 'make-clean.log')
        tool_command(target, ['make', '-j1', 'all'], board_dir, reports / 'make-all.log')
        for suffix in ('.bit', '.hwh'):
            path = board_dir / 'bitstream' / (args.design + suffix)
            if not path.is_file() or path.stat().st_size == 0:
                raise RuntimeError(f'Missing or empty output: {path}')
        metadata['status'] = 'build passed; manual board testing required'
        (output / 'build.json').write_text(json.dumps(metadata, indent=2) + '\n')
        archive = package_candidate(repo, args.board, args.design, output, metadata)
        print(f'Candidate: {archive}\nHardware/PYNQ testing has NOT been performed.', flush=True)
    except Exception as error:
        metadata['failed_stage'] = metadata['status']
        metadata['status'] = 'failed'
        metadata['error'] = str(error)
        raise
    finally:
        # The patch is the migration deliverable; keep the checkout reproducible.
        if original is not None:
            source_tcl.write_bytes(original)
        # Keep synthesis/implementation diagnostics even when the build fails.
        runs = board_dir / 'block_design/block_design.runs'
        if runs.is_dir():
            for path in runs.rglob('*'):
                if path.is_file() and (path.name == 'runme.log' or path.suffix == '.rpt'):
                    destination = reports / 'runs' / path.relative_to(runs)
                    destination.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(path, destination)
        (output / 'build.json').write_text(json.dumps(metadata, indent=2) + '\n')
        summary = os.environ.get('GITHUB_STEP_SUMMARY')
        if summary:
            with open(summary, 'a') as stream:
                stream.write(f'### {args.design} / {args.board}\n\n'
                             f'- Commit: `{metadata["commit"]}`\n'
                             f'- Status: {metadata["status"]}\n'
                             f'- Target: Vivado {args.target_version}, PYNQ {args.pynq_version}\n'
                             '- Manual board test: **not run**\n'
                             '- See artifact `build.json`, reports and any `upgrade.patch`.\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--design', required=True)
    parser.add_argument('--board', required=True)
    parser.add_argument('--source-version')
    parser.add_argument('--target-version')
    parser.add_argument('--build-only', action='store_true')
    parser.add_argument('--upgrade-only', action='store_true')
    parser.add_argument('--pynq-version', required=True)
    parser.add_argument('--preflight-only', action='store_true')
    run(parser.parse_args(), Path(__file__).resolve().parents[3])
