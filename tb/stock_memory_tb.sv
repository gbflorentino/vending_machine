module stock_memory_tb;
  logic clk;
  logic rst;
  logic mem_read;
  logic mem_write;

  logic [1:0] addr;

  logic [7:0] price;
  logic [7:0] stock;

  stock_memory dut(
    .clk(clk), 
    .rst(rst),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .addr(addr),
    .price(price),
    .stock(stock)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Wave files definition
  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars("stock_memory_tb", 0);
  end

  // Test procedure
  initial begin 
    clk = 0;
    rst = 1;
    mem_read = 0;
    mem_write = 0;
    addr = 2'd0;

    #20 begin
      rst = 0;
    end

    @(posedge clk) begin
      #1 $display("Addr=%b, Price=%d, Stock=%d, r=%b, w=%b", addr, price, stock, mem_read, mem_write);
    end

    // Product Addr
    addr = 2'd0;
    
    // Product stock
    mem_read = 1;

    @(posedge clk) begin
      #1 $display("Addr=%b, Price=%d, Stock=%d, r=%b, w=%b", addr, price, stock, mem_read, mem_write);
    end

    // Decrement product stock
    mem_read  = 0;
    mem_write = 1;

    @(posedge clk) begin
      #1 $display("Addr=%b, Price=%d, Stock=%d, r=%b, w=%b", addr, price, stock, mem_read, mem_write);
    end
    
    mem_read  = 1;
    mem_write = 0;
    @(posedge clk) begin
      #1 $display("Addr=%b, Price=%d, Stock=%d, r=%b, w=%b", addr, price, stock, mem_read, mem_write);
    end

    // Tests write on zero stock
    $display("Zero stock test");
    for(int i = 0; i < 5; i++) begin
      mem_read  = 0;
      mem_write = 1;

      @(posedge clk) begin
        #1 $display("Addr=%b, Price=%d, Stock=%d, r=%b, w=%b", addr, price, stock, mem_read, mem_write);
      end
      
      mem_read  = 1;
      mem_write = 0;

      @(posedge clk) begin
        #1 $display("Addr=%b, Price=%d, Stock=%d, r=%b, w=%b", addr, price, stock, mem_read, mem_write);
      end
    end 

    $finish;
  end

endmodule
