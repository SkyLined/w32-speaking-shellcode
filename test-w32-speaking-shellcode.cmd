@ECHO OFF

ECHO     + Checking shellcode for NULL bytes:
ECHO       + w32-speaking-shellcode.bin
CALL BETA3.cmd h --nullfree w32-speaking-shellcode.bin > nul
IF ERRORLEVEL 1 GOTO :FAILED
ECHO       + w32-speaking-shellcode-esp.bin
CALL BETA3.cmd h --nullfree w32-speaking-shellcode-esp.bin > nul
IF ERRORLEVEL 1 GOTO :FAILED
ECHO       + w32-speaking-shellcode-eaf.bin
CALL BETA3.cmd h --nullfree w32-speaking-shellcode-eaf.bin > nul
IF ERRORLEVEL 1 GOTO :FAILED

ECHO     + Running shellcode:
ECHO       + w32-speaking-shellcode.bin
w32-testival.exe [$]=ascii:w32-speaking-shellcode.bin eip=$ --EH --mem:address=28080000 2>&1 | CALL match_output.cmd "^Second chance debugger breakpoint exception at 0x2808[0-9A-F]{4}\.[\r\n]*$" --verbose >nul
IF ERRORLEVEL 1 GOTO :FAILED
ECHO       + w32-speaking-shellcode-esp.bin
w32-testival.exe --mem:size=10000 [$+F000]=ascii:w32-speaking-shellcode-esp.bin eip=$+F000 esp=$+EFFF --EH --mem:address=28080000  2>&1| CALL match_output.cmd "^Second chance debugger breakpoint exception at 0x2808[0-9A-F]{4}\.[\r\n]*$" --verbose >nul
IF ERRORLEVEL 1 GOTO :FAILED
ECHO       + w32-speaking-shellcode-eaf.bin (delayed by 2 seconds)
w32-testival.exe [$]=ascii:w32-speaking-shellcode-eaf.bin eip=$ --EH --mem:address=28080000 --delay=2000 2>&1 | CALL match_output.cmd "^Second chance debugger breakpoint exception at 0x2808[0-9A-F]{4}\.[\r\n]*$" --verbose >nul
IF ERRORLEVEL 1 GOTO :FAILED

EXIT /B 0

:FAILED
  ECHO     * Test failed!
  EXIT /B %ERRORLEVEL%