# Libs path configurations
set search_path "$search_path libs"
set target_library "saed32rvt_tt1p05v25c.db"
set link_library "* saed32rvt_tt1p05v25c.db dw_foundation.sldb"

analyze -format sverilog {
  rtl/vending_pkg.sv
  rtl/comparator.sv 
  rtl/subtractor.sv 
  rtl/coin_bin_to_value.sv 
  rtl/cash_register.sv 
  rtl/stock_memory.sv 
  rtl/control_unit.sv 
  rtl/vending_top.sv
}

elaborate vending_top
link

source synth/vending.sdc

check_design

compile_ultra 

redirect synth/reports/area_pos.rpt {
  report_area -hierarchy
}

redirect synth/reports/timing_relatorio.rpt {
  report_timing -max_paths 10 -nosplit
}

redirect synth/reports/power.rpt {
  report_power
}

redirect synth/reports/setup_violations.rpt {
  report_constraint -all_violators
}

write -format verilog -hierarchy -output synth/vending_syn.v
