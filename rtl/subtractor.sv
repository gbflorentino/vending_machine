module subtractor(
  input  [7:0] credit,
  input  [7:0] price,
  output [7:0] change
);

  assign change = credit - price;
  
endmodule
