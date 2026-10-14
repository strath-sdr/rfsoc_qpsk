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

## Run the workflow

1. Commit/push these workflow and script changes yourself. GitHub requires the
   dispatch workflow on the default branch before showing **Run workflow**.
2. Open **Actions → Vivado Build → Run workflow**; choose your branch and board.
3. Enter source and target versions, e.g. **2024.1 → 2025.2**, then run.
4. Wait for success; download **upgrade-<board>-<run>-<attempt>** under Artifacts.
5. Extract the candidate `.tar.gz` into a fresh directory on the board running
   PYNQ (e.g. 4.0). Follow the existing installation instructions there, then test the
   notebooks/overlay. Record your manual result.

Versions are free-text fields so adding a Vivado release needs no YAML edit.
Run once per board. Current ZCU216 Tcl uses **2020.2**: select that source version
and configure `VIVADO_2020_2_SETTINGS` for that board.

Pipeline:

**recreate in source Vivado → upgrade IP/export Tcl in target → recreate and
validate exported BD → make clean → make all → package/upload**.

`make all` uses the existing board Makefile: BD creation, bitstream, cleanup.
A failed stage or missing/empty `.bit` or `.hwh` prevents candidate packaging.
The existing Makefile/Vivado scripts determine build acceptance; there is no
additional timing-signoff or hardware test stage.

If the design already declares the target version, migration and the source
installation are skipped. An unexpected source version fails with an error.
Relevant same-repository PRs retain the RFSoC4x2 run with defaults
2024.1 → 2025.2; fork PRs run script tests only. Use manual runs for other boards
or versions.

## Keep the upgraded design

Artifacts contain the board installation archive, checksum, `build.json`, logs,
and (when migrated) exported Tcl plus `upgrade.patch`. Failed runs retain logs,
not an installation candidate. Retention: 30 days.

The job restores its original Tcl after packaging and does not commit or push.
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
`--preflight-only` for the full pipeline. Use a disposable checkout: generated
`block_design/` and `bitstream/` directories for that board are replaced.
