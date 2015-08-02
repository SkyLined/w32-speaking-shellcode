w32-speaking-shellcode
======================

A null-free shellcode for 32-bit versions of Windows 5.0-7.0 all service packs that uses [Microsoft Speech API]
(http://msdn.microsoft.com/en-us/library/ee705648.aspx) to say "You got pwned!" over the sound card. Includes optional
code that fixes stack alignment (adds 5 bytes).

Features:
* NULL Free
* Windows version and service pack independent.
* No assumptions are made about the values of registers.
* "/3GB" compatible: pointers are not assume to be smaller than 0x80000000.
* DEP/ASLR compatible: data is not executed, code is not modified.
* Windows 7 compatible: kernel32 is found based on the length of its name.
