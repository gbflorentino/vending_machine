module cash_register_tb;
  logic       clk;
  logic       rst;
  logic       credit_load;
  logic [1:0] coin_in;

  logic [7:0] credit;

  cash_register dut (.clk(clk), .rst(rst), .credit_load(credit_load), .coin_in(coin_in), .credit(credit));

  // Clock Generation
  always begin
    #5 clk = ~clk;
  end

  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0, cash_register_tb);
  end

  initial begin
    clk = 0;
    rst = 1;

    #20 begin
      rst = 0;
      credit_load = 1'b1;
    end

    // Adding a 0,25 coin
    coin_in = 2'b01;

    @(posedge clk) begin
      #1 $display("Coin_in=%b, credit=%d", coin_in, credit);
    end

    // Adding a 1,00 coin
    coin_in = 2'b11;

    @(posedge clk) begin
      #1 $display("Coin_in=%b, credit=%d", coin_in, credit);
    end

    // Adding a 0,50 coin 
    coin_in = 2'b10;

    @(posedge clk) begin
      #1 $display("Coin_in=%b, credit=%d", coin_in, credit);
    end

    // Deactivation credit load
    credit_load = 1'b0;

    @(posedge clk) begin
      #1 $display("Coin_in=%b, credit=%d", coin_in, credit);
    end

    $finish;
  end

endmodule
