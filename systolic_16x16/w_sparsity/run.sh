
# Remove old synthesis log
rm -rf Synthesis_log_run_sh.log

# Load Synopsys synthesis tool
#module load synopsys/syn/S-2021.06
module load synopsys/designcompiler/W-2024.09-SP4
module load synopsys/designcompiler/P-2019.03-SP5

# Run synthesis
design_vision -no_gui -f dc_script.tcl -output_log_file Synthesis_log_run_sh.log

# ---------------------------------------------
# ------------ For Error Report ---------------
echo ""
echo "------------ DC finished ---------------"
echo ""

set LOG_FILE = "Synthesis_log_run_sh.log"

# Check if the log file exists
if (! -e "$LOG_FILE") then
    echo "Log file not found: $LOG_FILE"
    echo ""
    exit 1
endif

# Search for lines starting with "Error:"
grep "^Error:" "$LOG_FILE" > /dev/null
if ($status == 0) then
    echo "Errors found in $LOG_FILE (showing up to 5 messages)"
    echo "---------------------------------"
    grep "^Error:" "$LOG_FILE" | head -n 5  # Limit to the first 5 error messages
    echo "---------------------------------"
    echo ""
    exit 1
else
    echo "No errors found in $LOG_FILE"
    echo ""
endif
# ------------ For Error Report ---------------
# ---------------------------------------------

# ---------------------------------------------
# ------ Automatically Run modify.sh ----------
# Extract NAME from generated "NAME.mapped.v"
set mapped_v_file = `ls *.mapped.v | head -n 1`  # Get the first .mapped.v file

if ("$mapped_v_file" == "") then
    echo "Error: No *.mapped.v file found after synthesis."
    exit 1
endif

echo "Running modify.sh on $mapped_v_file"
bash modify.sh "$mapped_v_file"

echo ""
echo "Flow Done!"
echo "" 
# ---------------------------------------------

