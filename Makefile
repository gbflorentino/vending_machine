# Directories
RTL_DIR   = rtl
TB_DIR    = tb
SYNTH_DIR = synth

# Lib
LIB = work

# Files
RTL_FILES = \
	$(RTL_DIR)/comparator.sv \
	$(RTL_DIR)/subtractor.sv \
	$(RTL_DIR)/coin_bin_to_value.sv \
	$(RTL_DIR)/cash_register.sv \
	$(RTL_DIR)/stock_memory.sv \
	$(RTL_DIR)/control_unit.sv \
	$(RTL_DIR)/vending_top.sv 

PKG_FILES = \
  $(RTL_DIR)/vending_pkg.sv \
	$(TB_DIR)/tb_utils_pkg.sv

TB_FILES = \
	$(TB_DIR)/comparator_tb.sv \
	$(TB_DIR)/subtractor_tb.sv \
	$(TB_DIR)/cash_register_tb.sv \
	$(TB_DIR)/stock_memory_tb.sv \
	$(TB_DIR)/control_unit_tb.sv \
	$(TB_DIR)/vending_top_tb.sv \

# Test Top-Module
TEST_TOP_MODULE = vending_top_tb

# Rules
syntax:
	vlogan -full64 -kdb -sverilog $(PKG_FILES) $(RTL_FILES) $(TB_FILES) +lint=all

compile: syntax
	vcs -full64 -debug_access+all -kdb -top $(TEST_TOP_MODULE) 

run: compile
	./simv 

wave: 
	verdi -ssf waves.fsdb &

synth:
	dc_shell -f $(SYNTH_DIR)/synth.tcl

clean_synth:
	rm -rf \
    $(SYNTH_DIR)/work \
    $(SYNTH_DIR)/*.rpt \
    $(SYNTH_DIR)/*.ddc \
    $(SYNTH_DIR)/*.db \
    $(SYNTH_DIR)/*_syn.v \
		*.mr \
		*.pvl \
		*.syn \
		*.svf \
		work.lib++/ \
		work++/ \
		alib-52  \
		cksum_dir  \
		*.pvk \
		work

clean_sim:
	rm -rf \
    csrc \
    simv* \
    *.daidir \
    novas* \
    AN.DB \
    ucli.key \
    verdi* \
    DVEfiles \
    .vlogan* \
    *.fsdb \
    *.log

clean: clean_sim clean_synth
