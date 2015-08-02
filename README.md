w32-speaking-shellcode
======================


Features:
* NULL Free
* Windows version and service pack independent.
* No assumptions are made about the values of registers.
* "/3GB" compatible: pointers are not assume to be smaller than 0x80000000.
* DEP/ASLR compatible: data is not executed, code is not modified.
* Windows 7 compatible: kernel32 is found based on the length of its name.

