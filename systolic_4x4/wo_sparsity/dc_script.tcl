
set TOP bitfusion

set sv_files [list  "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/bitfusion.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/accumulator.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/bit_brick.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/fusion_unit.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/in_mux.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/w_mux.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/shift_add.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/IBUF.sv" "/home/sparclab/a/gbarik/cadence/Verilog_codes/AI_hardware_Final/Final_results_code/Final_Code_v3/Final_code_v2/systolic_4x4/wo_sparsity/WBUF.sv"] 

set CLK "clk"
set RST "nRST"

set CLK_PERIOD 10;#ns
set CLK_UNCERTAINTY 0;
set my_max_delay 7;
# set this to ~70-90%; helps to avoid setup violations 

###################################### Notice Here #########################################################
# 2016.03-SP2
# set synthetic_library /package/eda/synopsys/syn-L-2016.03-SP2/libraries/syn/dw_foundation.sldb
# syn-S-2021.06
set synthetic_library /package/eda/synopsys/syn-S-2021.06/syn/S-2021.06/libraries/syn/dw_foundation.sldb

# old PDK
# set target_library /home/sparclab/a/das60/TECHNOLOGY/FROM_MOSIS/TSMC/65nm/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65lp_200a/tcbn65lptc1d0_ccs.db
# new PDK (2025)
set target_library  /home/sparclab/a/li4509/TSMC2024/tcbn65lp_220a/tcbn65lp_220a/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65lp_200a/tcbn65lptc1d0_ccs.db
###########################################################################################################


set link_library "* $target_library $synthetic_library"

set synthesized_verilog_file ${TOP}_syn_lib.sv
set flattened_verilog_file ${TOP}_syn_flat_lib.sv

# read RTL files
#analyze -f verilog $verilog_files
analyze -f sv $sv_files

# elaborate
elaborate $TOP
current_design $TOP

link
uniquify

# CLK related compile
create_clock $CLK -period $CLK_PERIOD
set_clock_uncertainty $CLK_UNCERTAINTY [all_clocks]
set_dont_touch_network [all_clocks]
set_max_delay ${my_max_delay} -to [all_outputs] 
set_max_delay ${my_max_delay} -from [remove_from_collection [all_inputs] [get_ports $CLK]] -to [all_registers -data_pins]

saif_map -start 
###################################### Notice Here #########################################################
# simple version
compile -map_effort high

# clock gating
#compile_ultra -gate_clock
############################################################################################################
check_design

# netlist with hierarchy
write -f verilog -hierarchy -o $synthesized_verilog_file

report_timing > timing.log 
report_area > area.log

#read_saif -input test_aes.saif -instance_name Top_PipelinedCipher_tb/U

report_power -analysis_effort high -hier > powerhier.log
report_power -analysis_effort high > power.log
# flattened netlist
ungroup -all -flatten
write -f verilog -o $flattened_verilog_file

# for combinational logic
report_power -cell > powercell.log
propagate_switching_activity -effort high
#report_saif 
#write_saif -output ckt1.saif -propagated
#write_sdc ./${TOP}_${my_max_delay}ns.sdc

write -format ddc -hierarchy -output $TOP.mapped.ddc
write -f verilog -hierarchy -output $TOP.mapped.v
#write_sdf top_module.mapped.sdf
write_sdc -nosplit $TOP.mapped.sdc
#write_milkyway -overwrite -output "top_module"

quit
