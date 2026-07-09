package vending_pkg;
  typedef enum bit [2:0] {
    IDLE,
    COLLECT,
    CHECK,
    DISPENSE,
    CHANGE,
    ERROR
  } control_states;
endpackage
