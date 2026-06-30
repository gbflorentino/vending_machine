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
	$(RTL_DIR)/cash_register.sv 

TB_FILES = \
	$(TB_DIR)/comparator_tb.sv \
	$(TB_DIR)/subtractor_tb.sv \
	$(TB_DIR)/cash_register_tb.sv 

# Top-Module
TOP_MODULE = cash_register

# Rules
syntax:
	vlogan -full64 -kdb -sverilog $(RTL_FILES) $(TB_FILES) +lint=all

compile: syntax
	vcs -full64 -debug_access+all -kdb -top $(TOP_MODULE)_tb

run: compile
	./simv
