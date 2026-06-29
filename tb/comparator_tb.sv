module comparator_tb;
  logic [7:0] credit;
  logic [7:0] stock;
  logic [7:0] price;

  logic can_sell;

  comparator dut(.credit(credit), .stock(stock), .price(price), .can_sell(can_sell));

  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0, comparator_tb);
  end

  initial begin
    // Testing credit >= price
    credit = 8'd150;
    price  = 8'd70;
    stock  = 8'd1;

    #1 $display("Credit=%d, Price=%d, Stock=%d, Can_sell=%b", credit, price, stock, can_sell);

    // Testing credit < price
    credit = 8'd70;
    price  = 8'd150;
    stock  = 8'd1;

    #1 $display("Credit=%d, Price=%d, Stock=%d, Can_sell=%b", credit, price, stock, can_sell);

    // Testing no stock
    credit = 8'd150;
    price  = 8'd50;
    stock  = 8'd0;

    #1 $display("Credit=%d, Price=%d, Stock=%d, Can_sell=%b", credit, price, stock, can_sell);
    $finish;
  end

endmodule
