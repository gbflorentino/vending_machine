module vending_top_tb;
  import vending_pkg::*;

  logic       clk;
  logic       rst;
  logic [1:0] coin_in;
  logic [1:0] sel_item;
  logic       confirm;
  logic       cancel;

  logic       dispense;
  logic [7:0] change_out;
  logic       error;
  logic [7:0] display;
  logic [2:0] state_out;

  logic change_allow;
  logic [7:0] price;

  logic [1:0] coins [];

  task buy_item(input logic [1:0] item, input logic [1:0] coins_added []);
    sel_item = item;
    
    foreach (coins_added[i])
      apply_coin(coin_in, coins_added[i], clk);

    confirm = 1;
    delay(4, clk);
  endtask

  vending_top dut(
    .clk(clk),
    .rst(rst),
    .coin_in(coin_in),
    .sel_item(sel_item),
    .confirm(confirm),
    .cancel(cancel),
    .dispense(dispense),
    .change_out(change_out),
    .error(error),
    .display(display),
    .state_out(state_out),
    .change_allow_debug(change_allow),
    .price_debug(price)
  );

  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpfile("vending_top_tb" , 0);
  end

  always begin
    #5 clk = ~clk;
  end

  initial begin
    $display("\n--------------------");
    $display(" Purchase successful  ");
    $display("-------------------- ");

    clk      = 0;
    rst      = 1;
    coin_in  = 0;
    sel_item = 0;
    confirm  = 0;
    cancel   = 0;


    #20 begin
      rst = 0;
    end

    coins = '{2'b11, 2'b11};
    buy_item(1'b0, coins);

    check(1, dispense, "Dispense");

    #1

    check(8'd75, change_out, "Change Out");
    check(8'd0, display, "Credit");


    $display("\n--------------------");
    $display("  Insuficient Funds   ");
    $display("--------------------  ");

    clk      = 0;
    rst      = 1;
    coin_in  = 0;
    sel_item = 0;
    confirm  = 0;
    cancel   = 0;

    #20 begin
      rst = 0;
    end

    coins = '{2'b10, 2'b10};
    sel_item = 3;
    
    foreach (coins[i])
      apply_coin(coin_in, coins[i], clk);

    confirm = 1;

    // Waits until gets to the Error State 
    delay(4, clk);

    check(1, error, "Error");
    check(8'd50, change_out, "Change out");
    
    $display("\n--------------------");
    $display("  Purchase cancel     ");
    $display("--------------------  ");

    clk      = 0;
    rst      = 1;
    coin_in  = 0;
    sel_item = 0;
    confirm  = 0;
    cancel   = 0;

    #20 begin
      rst = 0;
    end

    coins = '{2'b11, 2'b11, 2'b11};

    foreach (coins[i])
      apply_coin(coin_in, coins[i], clk);

    cancel = 1;

    delay(2, clk);

    check(0, display, "Credit");
    check(8'd200, change_out, "Change out");

    $display("\n--------------------");
    $display("    Stock Empty       ");
    $display("--------------------  ");

    clk      = 0;
    rst      = 0;
    coin_in  = 0;
    sel_item = 0;
    confirm  = 0;
    cancel   = 0;

    for (int i = 1; i <= 6; i++) begin
      coins = '{2'b11, 2'b11, 2'b11};
      buy_item(1'b0, coins);

      delay(4, clk);

      if (i <= 5)
        check(0, error, $sformatf("Error in %0d Purchase", i));
      else
        check(1, error, $sformatf("Error in %0d Purchase", i));
    end

   $display("");
   $finish;
  end
endmodule
