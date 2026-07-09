module subtractor(
  input  [7:0] credit,
  input  [7:0] price,

  output logic [7:0] change
);

  always_comb begin
    if (price > credit)
      change = credit;
    else
      change = credit - price;
  end
  
endmodule
