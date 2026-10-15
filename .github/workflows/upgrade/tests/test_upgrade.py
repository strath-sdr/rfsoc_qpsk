"""Exercise migration, artifact provenance and failure handling without FPGA tools."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import tarfile
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[4]
spec = importlib.util.spec_from_file_location('upgrade', ROOT / '.github/workflows/upgrade/upgrade.py')
upgrade = importlib.util.module_from_spec(spec)
spec.loader.exec_module(upgrade)

# A stand-in executable exercises the real subprocess/settings/log handling.
FAKE_VIVADO = '''#!/usr/bin/env python3
import os, sys
from pathlib import Path
version = os.environ['FAKE_VERSION']
if '-version' in sys.argv:
    print('vivado v' + version + ' (64-bit)')
    sys.exit(0)
stage, design, reports = sys.argv[sys.argv.index('-tclargs') + 1:]
with open(os.environ['FAKE_TRACE'], 'a') as f:
    f.write(stage + ':' + version + '\\n')
if os.environ.get('FAKE_FAIL') == stage:
    sys.exit(17)
if stage == 'recreate':
    Path('block_design').mkdir()  # Fails if migration was not followed by a clean rebuild.
elif stage == 'migrate':
    Path(design + '.tcl').write_text('set scripts_vivado_version ' + version + '\\n')
elif stage == 'build':
    assert not Path('bitstream').exists(), 'Stale bitstream was not removed'
    Path('bitstream').mkdir()
    for suffix in ['.bit', '.hwh']:
        if os.environ.get('FAKE_MISSING') != suffix:
            Path('bitstream', design + suffix).write_text('fresh ' + suffix)
'''


class UpgradeTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='vivado ci test ')
        self.addCleanup(self.temp.cleanup)
        self.repo = Path(self.temp.name)
        self.board = self.repo / 'boards/RFSoC4x2/demo'
        self.board.mkdir(parents=True)
        self.source = self.board / 'demo.tcl'
        self.source.write_text('set scripts_vivado_version 2024.1\n')
        (self.board / 'Makefile').write_text(
            'all: bitstream clean\n'
            'bitstream:\n\tvivado -tclargs recreate demo unused\n'
            '\tvivado -tclargs build demo unused\n'
            'clean:\n\trm -rf block_design\n')
        (self.repo / 'demo').mkdir()
        (self.repo / 'demo/__init__.py').write_text('')
        (self.repo / 'demo/stale.bit').write_text('must not ship')
        (self.repo / 'setup.py').write_text('# install fixture\n')
        subprocess.run(['git', 'init', '-q'], cwd=self.repo, check=True)
        subprocess.run(['git', 'add', '.'], cwd=self.repo, check=True)
        subprocess.run(['git', '-c', 'user.name=Test', '-c', 'user.email=test@example.invalid',
                        'commit', '-qm', 'fixture'], cwd=self.repo, check=True)
        env = {'FAKE_TRACE': str(self.repo / 'trace'), 'GITHUB_STEP_SUMMARY': ''}
        for version in ('2024.1', '2025.2'):
            tools = self.repo / ('tools ' + version)
            tools.mkdir()
            executable = tools / 'vivado'
            executable.write_text(FAKE_VIVADO)
            executable.chmod(0o755)
            settings = tools / 'settings64.sh'
            settings.write_text(f'export PATH="{tools}:$PATH"\nexport FAKE_VERSION={version}\n')
            env['VIVADO_' + version.replace('.', '_') + '_SETTINGS'] = str(settings)
        self.env = patch.dict(os.environ, env)
        self.env.start()
        self.addCleanup(self.env.stop)
        self.args = argparse.Namespace(design='demo', board='RFSoC4x2',
                                       source_version='2024.1', target_version='2025.2',
                                       pynq_version='4.0', preflight_only=False, build_only=False, upgrade_only=False)
        self.output = self.repo / '.ci-artifacts/RFSoC4x2'

    def test_migration_rebuild_patch_and_single_board_candidate(self):
        original = self.source.read_bytes()
        (self.board / 'bitstream').mkdir()
        (self.board / 'bitstream/demo.bit').write_text('stale')
        upgrade.run(self.args, self.repo)
        self.assertEqual(self.source.read_bytes(), original)
        self.assertEqual((self.repo / 'trace').read_text().splitlines(),
                         ['recreate:2024.1', 'migrate:2025.2', 'recreate:2025.2', 'recreate:2025.2', 'build:2025.2'])
        metadata = json.loads((self.output / 'build.json').read_text())
        self.assertTrue(metadata['generated_sources_need_commit'])
        self.assertEqual(metadata['hardware_test'], 'not run')
        subprocess.run(['git', 'apply', '--check', str(self.output / 'upgrade.patch')],
                       cwd=self.repo, check=True)
        with tarfile.open(next(self.output.glob('*.tar.gz'))) as archive:
            self.assertNotIn('demo/stale.bit', archive.getnames())
            self.assertEqual(archive.extractfile('boards/RFSoC4x2/demo/bitstream/demo.bit').read(),
                             b'fresh .bit')
            self.assertEqual(json.load(archive.extractfile('build.json')), metadata)
        self.assertTrue((self.output / 'reports/source-recreation/recreate-console.log').exists())
        self.assertTrue((self.output / 'reports/target-recreation/recreate-console.log').exists())

    def test_upgrade_only_when_already_target_has_no_change(self):
        self.source.write_text('set scripts_vivado_version 2025.2\n')
        self.args.upgrade_only = True
        with patch.dict(os.environ, {'VIVADO_2024_1_SETTINGS': '/does/not/exist'}):
            upgrade.run(self.args, self.repo)
        self.assertFalse((self.repo / 'trace').exists())
        self.assertEqual((self.output / 'demo.tcl').read_bytes(), self.source.read_bytes())
        self.assertEqual(json.loads((self.output / 'build.json').read_text())['status'],
                         'already at target version; no changes')

    def test_upgrade_only_leaves_tcl_and_skips_bitstream_build(self):
        self.args.upgrade_only = True
        upgrade.run(self.args, self.repo)
        self.assertEqual(upgrade.design_version(self.source), '2025.2')
        self.assertEqual((self.repo / 'trace').read_text().splitlines(),
                         ['recreate:2024.1', 'migrate:2025.2', 'recreate:2025.2'])
        self.assertFalse((self.board / 'bitstream').exists())
        self.assertFalse(list(self.output.glob('*.tar.gz')))
        self.assertEqual(json.loads((self.output / 'build.json').read_text())['status'],
                         'upgrade passed; commit generated Tcl')

    def test_build_only_uses_checked_in_version_without_migration(self):
        self.args.build_only = True
        self.args.source_version = None
        self.args.target_version = None
        with patch.dict(os.environ, {'VIVADO_2025_2_SETTINGS': '/does/not/exist'}):
            upgrade.run(self.args, self.repo)
        self.assertEqual((self.repo / 'trace').read_text().splitlines(),
                         ['recreate:2024.1', 'recreate:2024.1', 'build:2024.1'])
        self.assertFalse((self.output / 'upgrade.patch').exists())
        metadata = json.loads((self.output / 'build.json').read_text())
        self.assertEqual(metadata['target_vivado'], '2024.1')

    def test_already_upgraded_does_not_require_source_tool(self):
        self.source.write_text('set scripts_vivado_version 2025.2\n')
        with patch.dict(os.environ, {'VIVADO_2024_1_SETTINGS': '/does/not/exist'}):
            upgrade.run(self.args, self.repo)
        self.assertEqual((self.repo / 'trace').read_text().splitlines(),
                         ['recreate:2025.2', 'recreate:2025.2', 'build:2025.2'])
        self.assertFalse((self.output / 'upgrade.patch').exists())

    def test_failed_rerun_removes_old_candidate_and_restores_source(self):
        upgrade.run(self.args, self.repo)
        with patch.dict(os.environ, {'FAKE_FAIL': 'build'}):
            with self.assertRaises(RuntimeError):
                upgrade.run(self.args, self.repo)
        self.assertEqual(upgrade.design_version(self.source), '2024.1')
        self.assertEqual(list(self.output.glob('*.tar.gz')), [])
        self.assertEqual(json.loads((self.output / 'build.json').read_text())['status'], 'failed')
        self.assertTrue((self.output / 'upgrade.patch').exists())

    def test_missing_handoff_prevents_candidate(self):
        with patch.dict(os.environ, {'FAKE_MISSING': '.hwh'}):
            with self.assertRaisesRegex(RuntimeError, 'Missing or empty'):
                upgrade.run(self.args, self.repo)
        self.assertEqual(list(self.output.glob('*.tar.gz')), [])

    def test_wrong_tool_version_is_rejected_before_migration(self):
        with patch.dict(os.environ, {'VIVADO_2025_2_SETTINGS': os.environ['VIVADO_2024_1_SETTINGS']}):
            with self.assertRaisesRegex(ValueError, 'Expected Vivado 2025.2'):
                upgrade.run(self.args, self.repo)
        self.assertFalse((self.repo / 'trace').exists())

    def test_missing_runner_variable_is_rejected(self):
        with patch.dict(os.environ, {'VIVADO_2025_2_SETTINGS': ''}):
            with self.assertRaisesRegex(ValueError, "runner installation's .env"):
                upgrade.run(self.args, self.repo)

    def test_failed_validation_never_builds(self):
        with patch.dict(os.environ, {'FAKE_FAIL': 'recreate'}):
            with self.assertRaises(RuntimeError):
                upgrade.run(self.args, self.repo)
        self.assertNotIn('build:', (self.repo / 'trace').read_text())
        self.assertEqual(list(self.output.glob('*.tar.gz')), [])

    def test_unexpected_source_version_is_rejected(self):
        self.source.write_text('set scripts_vivado_version 2020.2\n')
        with self.assertRaisesRegex(ValueError, 'not the declared source or target'):
            upgrade.run(self.args, self.repo)

    def test_packaging_failure_does_not_publish_partial_candidate(self):
        with patch.object(tarfile.TarFile, 'add', side_effect=OSError('archive write failed')):
            with self.assertRaisesRegex(OSError, 'archive write failed'):
                upgrade.run(self.args, self.repo)
        self.assertEqual(list(self.output.glob('*.tar.gz')), [])
        self.assertEqual(list(self.output.glob('*.partial')), [])


@unittest.skipUnless(__import__('shutil').which('tclsh'), 'tclsh not installed')
class TclFailureTests(unittest.TestCase):
    def test_recreate_nonzero_return_fails_batch(self):
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            (directory / 'make_block_design.tcl').write_text('return 3\n')
            result = subprocess.run(['tclsh', str(ROOT / '.github/workflows/upgrade/vivado.tcl'),
                                     'recreate', 'demo', temp], cwd=temp, capture_output=True, text=True)
            self.assertEqual(result.returncode, 1)
            self.assertIn('Block design script returned failure: 3', result.stderr)


if __name__ == '__main__':
    unittest.main()
