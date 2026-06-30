# Makefile to compile and simulate Metastability CDC designs using Icarus Verilog

# Compiler and simulator executables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Target directories
RTL_DIR = ../rtl
TB_DIR = ../tb

# Source files
UNSAFE_SRCS = $(RTL_DIR)/metastability_unsafe.v $(TB_DIR)/tb_metastability_unsafe.v
SAFE_SRCS   = $(RTL_DIR)/metastability_safe.v $(TB_DIR)/tb_metastability_safe.v

# Output files
UNSAFE_OUT = sim_unsafe.vvp
SAFE_OUT   = sim_safe.vvp
UNSAFE_VCD = metastability_unsafe.vcd
SAFE_VCD   = metastability_safe.vcd

.PHONY: all compile_unsafe compile_safe run_unsafe run_safe clean view_unsafe view_safe help

all: run_unsafe run_safe

help:
	@echo "Available Makefile targets:"
	@echo "  make              - Compile and run both unsafe and safe simulations"
	@echo "  make compile      - Compile both designs without running"
	@echo "  make run_unsafe   - Compile and execute the unsynchronized simulation"
	@echo "  make run_safe     - Compile and execute the synchronized simulation"
	@echo "  make view_unsafe  - Open the unsynchronized simulation waveform in GTKWave"
	@echo "  make view_safe    - Open the synchronized simulation waveform in GTKWave"
	@echo "  make clean        - Delete all simulation binaries and VCD waveform dumps"

compile: compile_unsafe compile_safe

compile_unsafe:
	$(IVERILOG) -o $(UNSAFE_OUT) $(UNSAFE_SRCS)

compile_safe:
	$(IVERILOG) -o $(SAFE_OUT) $(SAFE_SRCS)

run_unsafe: compile_unsafe
	$(VVP) $(UNSAFE_OUT)

run_safe: compile_safe
	$(VVP) $(SAFE_OUT)

view_unsafe: run_unsafe
	$(GTKWAVE) $(UNSAFE_VCD) &

view_safe: run_safe
	$(GTKWAVE) $(SAFE_VCD) &

clean:
	rm -f $(UNSAFE_OUT) $(SAFE_OUT) $(UNSAFE_VCD) $(SAFE_VCD)
