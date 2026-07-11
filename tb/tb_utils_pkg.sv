package tb_utils_pkg;
  import vending_pkg::*;

  function automatic string get_state_name(input logic [2:0] state);
    control_states current_state;
    current_state = control_states'(state);
    return current_state.name();
  endfunction

  task automatic apply_coin(ref [1:0] coin_in, input [1:0] value, ref clk);
    coin_in = value;
    @(posedge clk) begin end
    coin_in = 2'd0;
  endtask

  task automatic check(input [7:0] expected, input [7:0] actual, input string label);
    string result;

    if (expected == actual)
      result = "PASS";
    else
      result = "FAIL";

    $display("%s Test result: %s, expected = %d, actual %d", label, result, expected, actual);
  endtask

  task automatic delay(int num_clocks, ref clk);
    for (int i = 0; i < num_clocks; i++)
      @(posedge clk) begin end
  endtask
endpackage;
