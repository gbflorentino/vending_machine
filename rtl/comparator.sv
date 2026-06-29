module comparator(
  input  logic [7:0] credit,
  input  logic [7:0] price,
  input  logic [7:0] stock,
  output logic       can_sell
);

  always_comb begin
    if ((credit >= price) & stock)
        can_sell = 1;
    else  
      can_sell=0;
  end

endmodule
