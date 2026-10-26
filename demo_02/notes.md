# 1

```asm
31 c0           xor     eax , eax   ; bitwise xor, sets eax to 0
50              push    eax         ; push 0 onto stack
68 6e 2f 73 68  push    0x68732f6e  ; push 0x68732f6e onto stack
68 2f 2f 62 69  push    0x69622f2f
89 e3           mov     ebx , esp   ; save esp in ebx
99              cdq                 ; extend eax to ebx (eax is 0 so ebx=0)
52              push    edx
53              push    ebx
89 e1           mov     ecx , esp   ; ecx <- esp
b0 0 b          mov     al  , 0xb   ; lower 8-bits of eax <- 0xb
cd 80           int     0x80        ; syscall (execve)
```

```-
Stack:
-----

h
s
/
n
i
b
/
/ <- A char
0
0
0
0
(4B) (char*)ptr_to_A <- (char**)B
^SP

Registers
---------
eax=0xb
ebx=ptr_to_A
ecx=ptr_to_B
edx=0
esp=
```

```c
char* argv[] = {"/bin/sh", NULL};
execve(argv[0], argv);
```

## 2

```asm
0x00000000   e8 00000000 call 0 x05 ; relative call +5
0x00000005   59          pop ecx
0x00000006   83 c1 1e    add ecx , 0 x1e
0x00000009   b8 04000000 mov eax , 4
0x0000000e   bb 01000000 mov ebx , 1
0x00000013   ba 0d000000 mov edx , 0 xd
0x00000018   cd 80       int 0 x80
0x0000001a   b8 01000000 mov eax , 1
0x0000001f   31 db       xor ebx , ebx
0x00000021   cd 80       int 0 x80
0x00000023   48          dec eax
0x00000024   65 6c       insb byte es :[ edi ] , dx
0x00000026   6c          insb byte es :[ edi ] , dx
0x00000027   6f          outsd dx , dword [ esi ]
0x00000028   20 57 6f    and byte [ edi + 0 x6f ] , dl
0x0000002b   72 6c       jb 0x99
0x0000002d   64 21 0a    and dword fs :[ edx ] , ecx
```

1.
   - `call` pushes the return address and jumps to the callee address
     - affects `sp`
   - `pop ecx` pops return address 0x05 into ecx

2. `sys_write` (0x4) and `sys_exit` (0x1)
   1. `sys_write`:
      - EAX=4
      - EBX=1
      - ECX=0x1e
      - EDX=0xd

   2. `sys_exit`:
      - EAX=1
      - EBX=0

3. exit with error code 0 (success)
