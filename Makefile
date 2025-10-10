SV_FILES = ${wildcard ./src/pkg/*.sv} ${wildcard ./src/*.sv}
TB_FILES = ${wildcard ./tb/*.sv}
ALL_FILES = ${SV_FILES} ${TB_FILES}

TEST_FILE ?= full_test

lint:
	@echo "Running lint checks..."
	verilator --lint-only -Wall --timing -Wno-UNUSED -Wno-CASEINCOMPLETE ${ALL_FILES}

build:
	verilator  --binary ${SV_FILES} ./tb/tb_pipe.sv --top tb_pipe -j 0 --trace -Wno-CASEINCOMPLETE

run: build
	obj_dir/Vtb_pipe

wave: run
	gtkwave --dark dump.vcd

# 4 byte display--> xxd -p -c 4 $(TEST_FILE).bin | sed 's/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/' > $(TEST_FILE).hex
test:
	cd test/$(TEST_FILE) && \
	/opt/riscv/bin/riscv32-unknown-elf-as -march=rv32ic -mabi=ilp32 -o $(TEST_FILE).o $(TEST_FILE).s && \
	/opt/riscv/bin/riscv32-unknown-elf-ld -Ttext=0x80000000 -o $(TEST_FILE).elf $(TEST_FILE).o && \
	/opt/riscv/bin/riscv32-unknown-elf-objdump -D $(TEST_FILE).elf > $(TEST_FILE).objdump && \
	/opt/riscv/bin/riscv32-unknown-elf-objcopy -O binary $(TEST_FILE).elf $(TEST_FILE).bin && \
	xxd -p -c 2 $(TEST_FILE).bin | sed 's/\(..\)\(..\)/\2\1/' > $(TEST_FILE).hex && \
	/opt/riscv/bin/spike -d --debug-cmd=$(TEST_FILE)_spike.script -l --log-commits -m0x7ffff000:0x20000000 --isa=rv32ic --log=$(TEST_FILE)_golden.log $(TEST_FILE).elf && \
	sed -i '1,5d; s/^core   0: 3 //' $(TEST_FILE)_golden.log && \
	rm -f $(TEST_FILE).o $(TEST_FILE).elf $(TEST_FILE).bin

clean:
	@echo "Cleaning temp files..."
	rm dump.vcd
	rm -r obj_dir

help: 
	@echo "Usage:"
	@echo "make test TEST_FILE=test_file"

.PHONY: compile run wave lint clean help test
