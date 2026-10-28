"""Exercise board selection with real PR diffs, without Vivado or GitHub."""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


SCRIPT = Path(__file__).resolve().parents[1] / 'select_boards.py'


class BoardSelectionTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.repo = Path(self.temp.name)
        for board in ('RFSoC4x2', 'ZCU111', 'ZCU208'):
            self.write(f'boards/{board}/demo/demo.tcl', 'original')
        self.write('boards/ip/core.tcl', 'original')
        self.git('init', '-q')
        self.commit()
        self.base = self.git('rev-parse', 'HEAD').strip()

    def write(self, name, content):
        path = self.repo / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content)

    def git(self, *args):
        return subprocess.check_output(['git', *args], cwd=self.repo, text=True)

    def commit(self):
        self.git('add', '.')
        self.git('-c', 'user.name=Test', '-c', 'user.email=test@example.invalid',
                 'commit', '-qm', 'fixture')

    def select(self, event_name='pull_request', board=None, base=None):
        event = {'inputs': {'board': board}} if event_name == 'workflow_dispatch' else {
            'pull_request': {'base': {'sha': base or self.base},
                             'head': {'sha': self.git('rev-parse', 'HEAD').strip()}}}
        event_path = self.repo / 'event.json'
        event_path.write_text(json.dumps(event))
        output = self.repo / 'output'
        output.unlink(missing_ok=True)
        result = subprocess.run(
            [sys.executable, str(SCRIPT), '--design', 'demo'], cwd=self.repo,
            env={**os.environ, 'GITHUB_EVENT_NAME': event_name,
                 'GITHUB_EVENT_PATH': str(event_path), 'GITHUB_OUTPUT': str(output)},
            capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        return json.loads(output.read_text().removeprefix('boards='))

    def test_upgrade_pr_builds_changed_board_only(self):
        self.write('boards/ZCU111/demo/demo.tcl', 'upgraded')
        self.commit()
        self.assertEqual(self.select(), ['ZCU111'])

    def test_multiple_boards_are_selected_once(self):
        self.write('boards/ZCU111/demo/demo.tcl', 'upgraded')
        self.write('boards/ZCU111/demo/constraints.xdc', 'changed')
        self.write('boards/ZCU208/demo/demo.tcl', 'upgraded')
        self.commit()
        self.assertEqual(self.select(), ['ZCU111', 'ZCU208'])

    def test_shared_changes_select_all_boards(self):
        for path in ('boards/ip/core.tcl', 'demo/overlay.py', 'setup.py',
                     '.github/workflows/upgrade/upgrade.py',
                     '.github/workflows/build_bitstreams.yml'):
            with self.subTest(path=path):
                base = self.git('rev-parse', 'HEAD').strip()
                self.write(path, 'changed')
                self.commit()
                self.assertEqual(self.select(base=base), ['RFSoC4x2', 'ZCU111', 'ZCU208'])

    def test_manual_run_keeps_explicit_board(self):
        self.assertEqual(self.select('workflow_dispatch', 'ZCU208'), ['ZCU208'])

    def test_unrelated_change_does_not_default_to_rfsoc4x2(self):
        self.write('README.md', 'documentation')
        self.commit()
        self.assertEqual(self.select(), [])

    def test_renamed_file_selects_both_boards(self):
        self.write('boards/ZCU111/demo/constraints.xdc', 'constraints')
        self.commit()
        self.base = self.git('rev-parse', 'HEAD').strip()
        self.git('mv', 'boards/ZCU111/demo/constraints.xdc',
                 'boards/ZCU208/demo/constraints.xdc')
        self.commit()
        self.assertEqual(self.select(), ['ZCU111', 'ZCU208'])

    def test_base_branch_changes_are_not_pr_changes(self):
        self.git('checkout', '-qb', 'upgrade')
        self.write('boards/ZCU111/demo/demo.tcl', 'upgraded')
        self.commit()
        self.git('checkout', '-qb', 'base-advanced', self.base)
        self.write('boards/ZCU208/demo/demo.tcl', 'unrelated base change')
        self.commit()
        new_base = self.git('rev-parse', 'HEAD').strip()
        self.git('checkout', '-q', 'upgrade')
        self.assertEqual(self.select(base=new_base), ['ZCU111'])


if __name__ == '__main__':
    unittest.main()
