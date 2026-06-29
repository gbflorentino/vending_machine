# Work directories
RTL_DIR = rtl
TB_DIR  = tb

# Files
RTL_FILES = \
	$(RTL_DIR)/comparator.sv \
	$(RTL_DIR)/subtractor.sv

TB_FILES = \
	$(TB_DIR)/comparator_tb.sv \
	$(TB_DIR)/subtractor_tb.sv

# Top-Module
TOP_MODULE = subtractor

syntax:
	vlogan -full64 -kdb -sverilog $(RTL_FILES) $(TB_FILES) +lint=all

compile: syntax
	vcs -full64 -debug_access+all -kdb -top $(TOP_MODULE)_tb

run: compile
	./simv
