create_clock -name clk -period 20 [get_ports clk]

set_clock_uncertainty 0.5 [get_clocks clk]

set_input_delay 3.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

set_output_delay 3.0 -clock clk [all_outputs]

set_load 0.05 [all_outputs]

set_driving_cell -lib_cell INVX1_RVT -library saed32rvt_tt1p05v25c [all_inputs]
