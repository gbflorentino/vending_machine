# Directories
RTL_DIR = rtl
TB_DIR  = tb

# Lib
LIB = work

# Files
RTL_FILES = \
	$(RTL_DIR)/comparator.sv \
	$(RTL_DIR)/subtractor.sv \
	$(RTL_DIR)/coin_bin_to_value.sv \
	$(RTL_DIR)/cash_register.sv \
	$(RTL_DIR)/stock_memory.sv \
	$(RTL_DIR)/control_unit.sv 

PKG_FILES = \
  $(RTL_DIR)/vending_pkg.sv

TB_FILES = \
	$(TB_DIR)/comparator_tb.sv \
	$(TB_DIR)/subtractor_tb.sv \
	$(TB_DIR)/cash_register_tb.sv \
	$(TB_DIR)/stock_memory_tb.sv \
	$(TB_DIR)/control_unit_tb.sv

# Test Top-Module
TEST_TOP_MODULE = control_unit_tb

# Rules
syntax:
	vlogan -full64 -kdb -sverilog $(PKG_FILES) $(RTL_FILES) $(TB_FILES) +lint=all

compile: syntax
	vcs -full64 -debug_access+all -kdb -top $(TEST_TOP_MODULE) 

run: compile
	./simv 
