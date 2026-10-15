# Vivado workflow

## Normal design changes

Edit the block design Tcl on a branch and open a PR into `main` or `master`.
**Vivado Build** runs automatically for RFSoC4x2: it reads the Vivado version
from the checked-in Tcl, recreates the BD, runs `make all`, and saves a
`bitstream-<board>-<run>-<attempt>` artifact. It does not upgrade Vivado.
Download the artifact and test the `.bit`/`.hwh` on the board.

To build another board or branch without a PR, use **Actions → Vivado Build →
Run workflow**, then select the board.

## Start a version upgrade

After this workflow is on the default branch, open **Actions → Vivado Upgrade →
Run workflow**. Choose board and source/target Vivado versions. The source
version must match the checked-in design Tcl. Start from the default branch.

On the self-hosted runner, the workflow recreates the old BD, upgrades IP in
the new Vivado version, exports Tcl, then recreates and validates that Tcl.
When it passes, a GitHub-hosted job commits only the generated board Tcl to an
upgrade branch and opens a PR. The PR's **Vivado Build** job then builds the
bitstream once. Download its artifact for manual board testing before merging.

The upgrade run also saves reports and `upgrade.patch` for diagnosis. No patch
download or manual recommit is needed in the normal flow. When a design is
already at the target version, no new PR is created.

One-time repository setting: **Settings → Actions → General → Workflow
permissions → Allow GitHub Actions to create and approve pull requests**.
Organization policy may control this. PR workflows created with the default
`GITHUB_TOKEN` may wait for a maintainer to click **Approve workflows to run**;
then the bitstream build starts. An App token can remove that approval later if
it proves inconvenient.

ZCU216 Tcl currently declares 2020.2; select that source version and configure
`VIVADO_2020_2_SETTINGS` on the runner when upgrading it.

## Runner setup

Each eligible self-hosted Linux x64 runner needs the Vivado version declared in
the board Tcl, board files and IP licences. An upgrade run needs both selected
Vivado versions. In the runner installation directory
(beside `run.sh` and `svc.sh`), set its local `.env` entry, for example:

```dotenv
VIVADO_2024_1_SETTINGS=/your/2024.1/settings64.sh
VIVADO_2025_2_SETTINGS=/your/2025.2/settings64.sh
```

Restart the runner after editing `.env`. The workflow sources the matching
version for the build. Fork PRs run script tests only, not the self-hosted job.

Run local orchestration tests with:

```sh
python3 -m unittest discover -s .github/workflows/upgrade/tests -v
```
