module coin_bin_to_value(
  input  logic [1:0] coin_in,
  output logic [7:0] coin_val
);

  always_comb begin
    case(coin_in) 
      2'b00:
        coin_val = 8'd00;
      2'b01:
        coin_val = 8'd25;
      2'b10:
        coin_val = 8'd50;
      2'b11:
        coin_val = 8'd100;
    endcase
  end
endmodule
