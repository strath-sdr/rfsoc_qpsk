# Run a Vivado upgrade

## Runner setup (once per machine)

Use the existing Linux x64 self-hosted runner. Install Python 3.9+, Git, Make,
both Vivado versions, required board files and IP licences.

In the **runner installation directory** (beside `run.sh` and `svc.sh`), edit `.env`:

```dotenv
VIVADO_2024_1_SETTINGS=/your/2024.1/installation/settings64.sh
VIVADO_2025_2_SETTINGS=/your/2025.2/installation/settings64.sh
```

Keep existing entries. Use absolute paths, no `export` or shell expansion.
These paths stay on the runner; do not commit `.env`. Add one variable per
installed version: `VIVADO_<year>_<release>_SETTINGS`.

Restart from that directory after edits:

```sh
sudo ./svc.sh stop
sudo ./svc.sh start
sudo ./svc.sh status
```

If the service has never been installed, run `sudo ./svc.sh install` first,
then start it. For a foreground runner, stop and restart `./run.sh` instead.
Every eligible runner needs the selected tools and variables. Each stage sources
only its selected version; shell aliases and `.bashrc` changes are unnecessary.

## Which workflow to run

**Vivado Build** runs on same-repository PRs into `main`/`master`. It reads the
Vivado version from each board's checked-in design Tcl, recreates the BD,
executes `make all`, and uploads a `bitstream-<board>-<run>-<attempt>` artifact.
It does not upgrade the design. PRs build RFSoC4x2 by default. To build another
board or branch without a PR, use **Actions → Vivado Build → Run workflow** and
choose the board. Fork PRs run only script tests on GitHub-hosted runners.

**Vivado Upgrade** runs only when you choose **Actions → Vivado Upgrade → Run
workflow**. Choose branch, board, source and target versions, then run. The
source version must match the checked-in design Tcl. It recreates the source
BD, upgrades IP and exports Tcl in the target version, recreates and validates
the exported BD, executes `make all`, then uploads the
`upgrade-<board>-<run>-<attempt>` artifact. It does not commit changes.

Versions are free-text fields, so adding a Vivado release needs no YAML edit.
Run once per board. Current ZCU216 Tcl uses **2020.2**: select that source version
and configure `VIVADO_2020_2_SETTINGS` for that board.

Both workflows require a nonempty `.bit` and `.hwh` before packaging. A green
build still needs manual testing on the intended PYNQ image.

## Keep the upgraded design

Artifacts contain the board installation archive, checksum, `build.json`, logs,
and (for upgrades) exported Tcl plus `upgrade.patch`. Failed runs retain logs,
not an installation candidate. Retention: 30 days.

The upgrade job restores its original Tcl after packaging and does not commit or push.
To keep the upgrade, apply the downloaded patch in the matching checkout:

```sh
git apply --check /path/to/upgrade.patch
git apply /path/to/upgrade.patch
```

Review, commit and push yourself. Rebuild after source changes before board testing.
PYNQ 4.0 is the intended board runtime; a successful build does not prove board
compatibility.

## Local checks

```sh
python3 -m unittest discover -s .github/workflows/upgrade/tests -v
python3 .github/workflows/upgrade/upgrade.py --design rfsoc_qpsk --board RFSoC4x2 \
  --source-version 2024.1 --target-version 2025.2 --pynq-version 4.0 \
  --preflight-only
```

Export the same settings variables in your terminal for local runs; the Python
script uses the process environment, not a repository `.env`. Omit
`--preflight-only` for the full upgrade pipeline. Use `--build-only` with no
version arguments for the checked-in design. Use a disposable checkout: generated
`block_design/` and `bitstream/` directories for that board are replaced.
