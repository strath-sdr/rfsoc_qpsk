set overlay_name "rfsoc_qpsk"
set design_name "block_design"

# Open project
open_project ./${overlay_name}/${overlay_name}.xpr

# Make block design
source ./${design_name}.tcl