SV_FILES = ${wildcard ./src/pkg/*.sv} ${wildcard ./src/*.sv}
TB_FILES = ${wildcard ./tb/*.sv}
ALL_FILES = ${SV_FILES} ${TB_FILES}


lint:
	@echo "Running lint checks..."
	verilator --lint-only -Wall --timing -Wno-UNUSED -Wno-CASEINCOMPLETE ${ALL_FILES}

build:
	verilator  --binary ${SV_FILES} ./tb/tb.sv --top tb -j 0 --trace -Wno-CASEINCOMPLETE

run: build
	obj_dir/Vtb

wave: run
	gtkwave --dark dump.vcd

test:
	cd test && \
	/opt/riscv/bin/riscv32-unknown-elf-as -march=rv32i_zbb -mabi=ilp32 -o test2.o test2.s && \
	/opt/riscv/bin/riscv32-unknown-elf-ld -Ttext=0x80000000 -o test2.elf test2.o && \
	/opt/riscv/bin/riscv32-unknown-elf-objdump -D test2.elf > test2.objdump && \
	/opt/riscv/bin/riscv32-unknown-elf-objcopy -O binary test2.elf test2.bin && \
	xxd -p -c 4 test2.bin | sed 's/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/' > test2.hex && \
	/opt/riscv/bin/spike -d --debug-cmd=spike.script -l --log-commits -m0x7ffff000:0x20000000 --isa=rv32i_zbb --log=test2.log test2.elf && \
	sed -i '1,5d; s/^core   0: 3 //' test2.log && \
	rm -f test2.o test2.elf test2.bin




clean:
	@echo "Cleaning temp files..."
	rm dump.vcd
	rm -r obj_dir


.PHONY: compile run wave lint clean help test
