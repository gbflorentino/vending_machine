module control_unit(
  input  logic       clk,
  input  logic       rst,
  input  logic [1:0] coin_in,
  input  logic       confirm,
  input  logic       cancel,
  input  logic       can_sell,

  output logic       credit_load,
  output logic       mem_read,
  output logic       mem_write,
  output logic       dispense,
  output logic       error,
  output logic [2:0] state_debug,
  output logic       credit_rst,
  output logic       change_allow
);

  import vending_pkg::*;

  logic [2:0] state;
  logic [2:0] next_state;
  
  logic check_wait_flag;

  always_ff @(posedge clk) begin
    if (rst) 
      check_wait_flag <= 0;
    else if (state == CHECK)
      check_wait_flag <= 1;
    else 
      check_wait_flag <= 0;
  end

  always_ff @(posedge clk) begin 
    if (rst) 
      state <= IDLE;
    else 
      state <= next_state;
  end

  always_comb begin
    case(state)
      IDLE: begin
        if (coin_in == 0) 
          next_state = IDLE;
        else 
          next_state = COLLECT;
      end 

      COLLECT: begin
        if (confirm)
          next_state = CHECK;
        else if (cancel)
          next_state = CHANGE;
        else
          next_state = COLLECT;
      end

      CHECK: begin
        if (check_wait_flag == 1) begin
          if (can_sell) 
            next_state = DISPENSE;
          else
            next_state = ERROR;
        end
        else if (cancel)
          next_state = CHANGE;
        else 
          next_state = CHECK;
      end

      DISPENSE: begin
        next_state = CHANGE;
      end

      CHANGE: begin
        next_state = IDLE;
      end

      ERROR: begin
        if (cancel) 
          next_state = IDLE;
        else
          next_state = ERROR;
      end

      default: begin
        next_state = IDLE;
      end

    endcase
  end

  always_comb begin
    credit_load      = 0;
    mem_read         = 0;
    mem_write        = 0;
    dispense         = 0;
    error            = 0;
    credit_rst       = 0;
    change_allow     = 0;
     
    case (state)
      IDLE: begin
        credit_rst   = 1;
      end

      COLLECT: begin
        credit_load  = 1;
      end

      CHECK: begin
        mem_read     = 1;
      end

      DISPENSE: begin
        mem_write    = 1;
        dispense     = 1;
      end

      CHANGE: begin
        credit_rst   = 1;
        change_allow = 1;
      end

      ERROR: begin 
        error        = 1;
        credit_rst   = 1;
        change_allow = 1;
      end
    endcase
  end

  assign state_debug = state;

endmodule
