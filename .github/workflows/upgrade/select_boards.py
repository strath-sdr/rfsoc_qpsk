#!/usr/bin/env python3
"""Select the manual board or the boards affected by a pull request."""
import argparse
import json
import os
from pathlib import Path
import re
import subprocess


def select_boards(repo, design, event_name, event):
    supported = sorted(path.parent.parent.name
                       for path in (repo / 'boards').glob(f'*/{design}/{design}.tcl'))
    if not supported:
        raise ValueError(f'No board designs found for {design}')
    if event_name == 'workflow_dispatch':
        board = event['inputs']['board']
        if board not in supported:
            raise ValueError(f'Unsupported board: {board}')
        return [board]
    if event_name != 'pull_request':
        raise ValueError(f'Unsupported event: {event_name}')

    pr = event['pull_request']
    base, head = pr['base']['sha'], pr['head']['sha']
    if not all(re.fullmatch(r'[0-9a-fA-F]{40}', sha) for sha in (base, head)):
        raise ValueError('Expected full base and head commit SHAs')
    # Three-dot comparison excludes changes made only on the base branch.
    # Disabling rename detection includes both board paths when files move.
    changed = subprocess.check_output(
        ['git', 'diff', '--name-only', '--no-renames', '-z', f'{base}...{head}', '--'],
        cwd=repo).decode().split('\0')
    selected = set()
    for path in filter(None, changed):
        if (path.startswith(('boards/ip/', design + '/', '.github/workflows/upgrade/'))
                or path in ('setup.py', '.github/workflows/build_bitstreams.yml')):
            return supported
        parts = path.split('/')
        if parts[0] == 'boards':
            if len(parts) == 2:
                return supported  # Shared helpers directly under boards/.
            if len(parts) > 2 and parts[1] in supported:
                selected.add(parts[1])
    return sorted(selected)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--design', required=True)
    args = parser.parse_args()
    event = json.loads(Path(os.environ['GITHUB_EVENT_PATH']).read_text())
    boards = select_boards(Path.cwd(), args.design, os.environ['GITHUB_EVENT_NAME'], event)
    value = json.dumps(boards, separators=(',', ':'))
    with open(os.environ['GITHUB_OUTPUT'], 'a') as output:
        output.write(f'boards={value}\n')
    print(f'Selected boards: {value}')
