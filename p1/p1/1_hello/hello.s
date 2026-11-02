0x08049000 <+0>:     b8 04 00 00 00      mov    eax,0x4                 ; syscall operation: sys_write
0x08049005 <+5>:     bb 01 00 00 00      mov    ebx,0x1                 ; syscall argument: fd=1 (stdout)
0x0804900a <+10>:    b9 1f 90 04 08      mov    ecx,0x804901f           ; buf=0x804901f pointer to string buffer
0x0804900f <+15>:    ba 0d 00 00 00      mov    edx,0xd                 ; count = 0xd = 13
0x08049014 <+20>:    cd 80               int    0x80                    ; do syscall (write)
0x08049016 <+22>:    b8 01 00 00 00      mov    eax,0x1                 ; syscall operation: exit
0x0804901b <+27>:    31 db               xor    ebx,ebx                 ; exit code = 0
0x0804901d <+29>:    cd 80               int    0x80                    ; do syscall (exit)
0x0804901f <+31>:    48                  dec    eax                     ; start of buf string (char*), 48 = 'H'
0x08049020 <+32>:    65 6c               gs ins BYTE PTR es:[edi],dx    ; 65 6c = 'e' 'l'
0x08049022 <+34>:    6c                  ins    BYTE PTR es:[edi],dx    ; 'l'
0x08049023 <+35>:    6f                  outs   dx,DWORD PTR ds:[esi]   ; 'o'
0x08049024 <+36>:    20 57 6f            and    BYTE PTR [edi+0x6f],dl  ; " Wo"
0x08049027 <+39>:    72 6c               jb     0x8049095               ; "rl"
0x08049029 <+41>:    64 21 0a            and    DWORD PTR fs:[edx],ecx  ; "d!\n"
0x0804902c <+44>:    00                  .byte 0                        ; last byte of string was 0x804901f + 13 - 1 = 0x804902b
