module stock_memory(
  input              clk,
  input              rst,
  input              mem_read,
  input              mem_write,
  input  logic [1:0] addr,
  output logic [7:0] price,
  output logic [7:0] stock
);

  logic [15:0] memory[3:0];
  
  always_ff @(posedge clk) begin
    if (rst) begin
      // Memory initial state 
      memory[2'd0] <= {8'h19, 8'h5};
      memory[2'd1] <= {8'h32, 8'h5};
      memory[2'd2] <= {8'h4B, 8'h3};
      memory[2'd3] <= {8'h64, 8'h2};
      // Memory default output
      price <= 8'd0;
      stock <= 8'd0;
    end
    else begin
      case ({mem_read, mem_write})
        2'b01: begin
          price <= 8'd0;
          stock <= 8'd0;
          // Ensure stock don't becomes negative
          if (memory[addr][7:0] != 8'd0)
            memory[addr] <= memory[addr] - 1;
        end
        2'b10: begin
          price <= memory[addr][15:8];
          stock <= memory[addr][7:0];
        end
        default: begin
          price <= 8'd0;
          stock <= 8'd0;
        end
      endcase
    end
  end
endmodule
