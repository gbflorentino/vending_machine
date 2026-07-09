module control_unit_tb;
  import vending_pkg::*;

  logic       clk;
  logic       rst;
  logic [1:0] coin_in;
  logic       confirm;
  logic       cancel;
  logic       can_sell;

  logic       credit_load;
  logic       mem_read;
  logic       mem_write;
  logic       dispense;
  logic       error;
  logic [2:0] state_debug;
  
  function automatic string get_state_name(input logic [2:0] state);
    control_states current_state;
    current_state = control_states'(state);
    return current_state.name();
  endfunction

  control_unit dut(
    .clk(clk),
    .rst(rst),
    .coin_in(coin_in),
    .confirm(confirm),
    .cancel(cancel),
    .can_sell(can_sell),
    .credit_load(credit_load),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .dispense(dispense),
    .error(error),
    .state_debug(state_debug)
  );

  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpfile("control_unit_tb" , 0);
  end

	always begin
    #5 clk = ~clk;
  end

  initial begin
    clk      = 0;
    rst      = 1;
    confirm  = 0;
    cancel   = 0;
    can_sell = 0;
    coin_in  = 0;

    #20 begin
      rst = 0;
    end

    $display("\n-------------------");
    $display("   Error flow"       );
    $display("------------------- ");

    @(posedge clk) begin
      #1 $display("Credit_load=%b, State=%s", credit_load, get_state_name(state_debug));
    end

    $display("Added Coin_in = 2'b11");
    coin_in = 2'b11;

    for (int i = 0; i <= 1; i++) begin
      @(posedge clk) begin
        #1 $display("Credit_load=%b, State=%s", credit_load, get_state_name(state_debug));
      end
    end

    $display("Changed Confirm = 1");
    confirm = 1;

    for (int i = 0; i <= 3; i++) begin
      if (i == 3) 
        cancel = 1;
      else
        cancel = 0;
      @(posedge clk) begin
        #1 $display("Credit_load=%b, State=%s", credit_load, get_state_name(state_debug));
      end
    end

    $display("\n--------------------");
    $display("   Normal flow        ");
    $display("--------------------  ");

    coin_in = 0;

    @(posedge clk) begin
      #1 $display("Credit_load=%b, State=%s", credit_load, get_state_name(state_debug));
    end

    coin_in = 2'b01;

    @(posedge clk) begin
      #1 $display("Credit_load=%b, State=%s", credit_load, get_state_name(state_debug));
    end

    confirm = 1;

    @(posedge clk) begin
      #1 $display("Credit_load=%b, State=%s", credit_load, get_state_name(state_debug));
    end

    can_sell = 1;
    coin_in  = 0;
 
    for (int i = 0; i <= 3; i++) begin
      @(posedge clk) begin
        #1 $display("Credit_load=%b, State=%s", credit_load, get_state_name(state_debug));
      end
    end

    $display("");
    $finish;
  end

endmodule
