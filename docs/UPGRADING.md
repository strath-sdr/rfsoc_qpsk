# PYNQ / Vivado upgrade procedure

The first pilot targets **RFSoC4x2, PYNQ 4.0 and Vivado 2025.2**, starting from Vivado 2024.1. These are targets; a green build does not establish PYNQ or board compatibility. This pilot workflow replaces the previous five-board build matrix with RFSoC4x2 only. Expand the matrix before claiming a full multi-board upgrade.

## Prepare the runner once

The existing self-hosted Linux x64 runner needs Python 3.9 or newer, Git, Bash, both Vivado versions, the RFSoC4x2 board files and any necessary IP licences. Only branches within this repository are eligible for the self-hosted job; fork PRs run the orchestration tests only.

The script searches these locations for each declared Vivado version:

- `/tools/Xilinx/Vivado/<version>/settings64.sh`
- `/tools/Xilinx/<version>/Vivado/settings64.sh`
- The same two layouts under `/opt/Xilinx`.

For another installation layout, set `VIVADO_2024_1_SETTINGS` and `VIVADO_2025_2_SETTINGS` in the runner service environment to the appropriate `settings64.sh` files, then restart the service. Each selected executable is checked with `vivado -version`. Once the committed design uses the target version, the source installation is no longer required.

Confirm the PYNQ 4.0 image for the pilot board separately. Setting `TARGET_PYNQ` records the intended runtime; it does not install PYNQ or run tests on a board.

## Start an upgrade

1. Create an upgrade branch and edit `SOURCE_VIVADO`, `TARGET_VIVADO`, `TARGET_PYNQ`, and the board matrix in `.github/workflows/build_bitstreams.yml`.
2. Open a PR and use the checklist below in its description. Relevant changes automatically start the workflow; no separate Actions button is needed.
3. The job verifies the tools, recreates the source design, upgrades locked IP, validates and exports Tcl, recreates a fresh project in the target version, and calls the existing board bitstream script. Migration is skipped when the committed Tcl already declares the target version.
4. The build checks completion, setup/hold/pulse-width slack, DRC errors/critical warnings and remaining locked IP. Reports are retained. Unconstrained paths and other warnings remain in the reports for review; they are not covered by the numeric slack checks.
5. Download the `upgrade-<board>-<run>-<attempt>` artifact. It contains reports, `build.json`, a successful candidate `.tar.gz` and its `SHA256SUMS`, plus an exported Tcl and `upgrade.patch` when migration was needed. Artifacts are retained for 30 days.
6. Review the patch. In the matching clean checkout, run `git apply --check /path/to/upgrade.patch`, then `git apply /path/to/upgrade.patch`. Commit and push the Tcl on the same PR. That triggers a fresh build from committed sources. Use this later candidate for final board acceptance.
7. Verify the archive checksum and test the candidate on the specified board image. Record the run URL, built commit and archive checksum. Any subsequent source change requires a new build and relevant retesting.
8. Merge and publish the tested artifacts after review. No script creates commits, merges a PR, marks a board passed, or publishes a release.

The archive includes the existing Python package, notebooks, installer and only the selected board's fresh `.bit`/`.hwh`. To test it, extract it into a new directory on the board and follow the existing package installation procedure from that directory. Confirm `BOARD` and `PYNQ_JUPYTER_NOTEBOOKS` are set correctly. Test installation and dependencies on the actual image; this pilot does not assume the existing installer is already compatible with PYNQ 4.0.

Source migration is delivered as a patch, and the original Tcl in the build checkout is restored afterward. `build.json` records whether generated sources still need committing. Build candidates requiring that commit are preliminary.

## Local diagnosis

Use a disposable clean checkout: the script replaces generated `block_design/` and `bitstream/` directories for the selected board. From the repository root:

```sh
python3 -m unittest discover -s tests/ci -v
python3 scripts/ci/upgrade.py --design rfsoc_qpsk --board RFSoC4x2 \
  --source-version 2024.1 --target-version 2025.2 --pynq-version 4.0 \
  --preflight-only
```

Omit `--preflight-only` to run the complete build locally. Logs and metadata are under `.ci-artifacts/RFSoC4x2/`. The workflow's `Run workflow` option is retained for diagnosis or rebuilding an existing branch.

## PR checklist

- [ ] Record source/target Vivado, PYNQ image identifier/checksum and boards in scope.
- [ ] Confirm both tools, board files and licences on the runner.
- [ ] Review migration/IP reports; commit the generated Tcl.
- [ ] Confirm the subsequent build uses committed Tcl and passes timing/DRC checks.
- [ ] Review timing constraints, unconstrained paths and remaining warnings.
- [ ] Verify and install the final candidate on the recorded PYNQ image.
- [ ] Load the overlay, initialise clocks/converters, exercise data transfer and run the QPSK demonstration notebooks and widgets.
- [ ] Record manual results below; an unavailable board is unvalidated, not passed.
- [ ] Update package version and tested compatibility/install documentation as required by the results.
- [ ] Merge and release only the reviewed, tested candidate.

| Board | Image/checksum | Run URL and built commit | Archive/checksum | Install + overlay | QPSK test result | Tester/date |
| --- | --- | --- | --- | --- | --- | --- |
| RFSoC4x2 | | | | | | |

Record the actual checked-out commit from `build.json`; on PR runs this can be GitHub's temporary merge commit. The old `/hw-pass` and `/hw-fail` instructions have been removed: record hardware acceptance in the PR rather than creating pending checks without a handler.

ZCU216 has a 2020.2 design and a separate image history. Resolve its source tool and runtime image before adding it. The other boards are also outside this pilot until included and tested. Once this process works end to end, extract the common job into a pinned `workflow_call` workflow for OFDM and radio; the scripts already accept a design name and board.
