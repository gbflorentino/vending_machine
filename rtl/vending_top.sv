module vending_top(
  input        clk,
  input        rst,
  input  [1:0] coin_in,
  input  [1:0] sel_item,
  input        confirm,
  input        cancel,

  output logic       dispense,
  output logic [7:0] change_out,
  output logic       error,
  output logic [7:0] display,
  output logic [2:0] state_out,
  output logic change_allow_debug,
  output logic [7:0] price_debug
);

  logic       credit_load;
  logic [7:0] credit;
  logic [7:0] price;
  logic [7:0] stock;
  logic       can_sell;
  logic       mem_read;
  logic       mem_write;
  logic [7:0] change;
  logic       credit_rst;
  logic       change_allow;

  cash_register u_cash_register(
    .clk(clk),
    .rst(rst),  
    .credit_rst(credit_rst),
    .credit_load(credit_load),
    .coin_in(coin_in),
    .credit(credit)
  );

  comparator u_comparator( 
    .credit(credit),
    .price(price),
    .stock(stock),
    .can_sell(can_sell)
  );

  stock_memory u_stock_memory(
    .clk(clk),
    .rst(rst),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .addr(sel_item),
    .price(price),
    .stock(stock)
  );

  subtractor u_subtractor(
    .credit(credit),
    .price(price),
    .change(change)
  );

  control_unit u_control_unit(
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
    .state_debug(state_out),
    .credit_rst(credit_rst),
    .change_allow(change_allow)
  );

  assign change_allow_debug = change_allow;
  assign price_debug = price;

  always_comb begin
    if (change_allow) begin
      display    = 0;
      change_out = (cancel) ? credit : change;
    end 
    else begin
      display    = credit;
      change_out = 0;
    end
  end

endmodule
