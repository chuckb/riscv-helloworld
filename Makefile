default: hello

hello: hello.o baremetal.ld
	riscv64-unknown-elf-gcc -T baremetal.ld -march=rv32i -mabi=ilp32 -nostdlib -static -o hello hello.o

hello.o: hello.s
	riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 hello.s -o hello.o

run: hello
	@echo "Ctrl-A C for QEMU console, then quit to exit"
	qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios hello
