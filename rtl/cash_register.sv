module cash_register(
  input  logic       clk, 
  input  logic       rst,
  input  logic       credit_load,
  input  logic       credit_rst,
  input  logic [1:0] coin_in,
  output logic [7:0] credit
);

  logic [7:0] coin_val;

  coin_bin_to_value dut(.coin_in(coin_in), .coin_val(coin_val));

  always_ff @(posedge clk or posedge rst) begin
    if (rst || credit_rst) 
      credit <= 8'd0;
    else begin
      if (credit_load)
        credit <= credit + coin_val;
      else
        credit <= credit;
    end
  end
endmodule
