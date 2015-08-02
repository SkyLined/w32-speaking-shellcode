build_config = {
  "version": "0.1",
  "projects": {
    "w32-speaking-shellcode-hash-list.asm": {                               # List of hashes
      "files": {
        "w32-speaking-shellcode-hash-list.asm": {
          "sources": ["w32-speaking-shellcode-hash-list.txt"],
          "build commands": [
              ["hash\\hash.cmd",
                "--input=w32-speaking-shellcode-hash-list.txt",
                "--output=w32-speaking-shellcode-hash-list.asm"],
          ],
        },
      },
    },
    "w32-speaking-shellcode.bin": {
      "architecture": "x86",
      "dependencies": ["w32-speaking-shellcode-hash-list.asm"],
      "files": {
        "w32-speaking-shellcode.bin": {
          "sources":  ["w32-speaking-shellcode.asm"],
          "includes": ["w32-speaking-shellcode-hash-list.asm"],
        },
      },
    },
    "w32-speaking-shellcode-esp.bin": {
      "architecture": "x86",
      "dependencies": ["w32-speaking-shellcode-hash-list.asm"],
      "files": {
        "w32-speaking-shellcode-esp.bin": {
          "sources":  ["w32-speaking-shellcode.asm"],
          "includes": ["w32-speaking-shellcode-hash-list.asm"],
          "defines":  {"STACK_ALIGN": "TRUE"},
        },
      },
    },
    "w32-speaking-shellcode-eaf.bin": {
      "architecture": "x86",
      "dependencies": ["w32-speaking-shellcode-hash-list.asm"],
      "files": {
        "w32-speaking-shellcode-eaf.bin": {
          "sources":  ["w32-speaking-shellcode.asm"],
          "includes": ["w32-speaking-shellcode-hash-list.asm"],
          "defines":  {"DEFEAT_EAF": "TRUE"},
        },
      },
    },
    "Speak.exe": {
      "architecture": "x86",
      "files": {
        "Speak.exe": {
          "sources":  ["Speak.obj"],
          "libs":  ["ole32.lib"],
        },
        "Speak.obj": {
          "sources":  ["Speak.cpp"],
        },
      },
    },
  },
  "test commands": ["test-w32-speaking-shellcode.cmd"],
}
