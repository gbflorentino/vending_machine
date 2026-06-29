module subtractor_tb;
  logic [7:0] credit;
  logic [7:0] price;
  logic [7:0] change;

  subtractor dut (.credit(credit), .price(price), .change(change));

  initial begin
    // Credit greater than price 
    credit = 8'd150;
    price = 8'd50;

    #1 $display("Credit=%d, Price=%d, Change=%d", credit, price, change);

    // Credit lesser than price 
    credit = 8'd50;
    price = 8'd150;

    #1 $display("Credit=%b, Price=%b, Change=%b", credit, price, change);

    // Credit equals to price 
    credit = 8'd150;
    price = 8'd150;

    #1 $display("Credit=%d, Price=%d, Change=%d", credit, price, change);
 
  end
endmodule
