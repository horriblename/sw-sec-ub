; Dump of assembler code for function explain_me:
   0x0000000000401140 <+0>:     push   rbp
   0x0000000000401141 <+1>:     mov    rbp,rsp
   0x0000000000401144 <+4>:     sub    rsp,0x10 ; 16-byte stack allocation
   ; let a be [rbp-4]
   ; let b be [rbp-8]
   ; let c be [rbp-0xc]
   ; let d be [rbp-0x10]
   ; DWORD: 4 byte
   0x0000000000401148 <+8>:     mov    DWORD PTR [rbp-0x8],edi  ; b := edi ; first arg (32-bit)
   0x000000000040114b <+11>:    cmp    DWORD PTR [rbp-0x8],0x2
   0x000000000040114f <+15>:    jl     0x40117d <explain_me+61> ; jump if b < 2
   0x0000000000401155 <+21>:    mov    edi,DWORD PTR [rbp-0x8]
   0x0000000000401158 <+24>:    sub    edi,0x1                  ; edi := b - 1
   0x000000000040115b <+27>:    call   0x401140 <explain_me>    ; explain_me(b-1)
   0x0000000000401160 <+32>:    mov    DWORD PTR [rbp-0xc],eax  ; c = explain_me(b-1)
   0x0000000000401163 <+35>:    mov    edi,DWORD PTR [rbp-0x8]
   0x0000000000401166 <+38>:    sub    edi,0x2                  ; edi := b - 2
   0x0000000000401169 <+41>:    call   0x401140 <explain_me>    ; explain_me(b-2)
   0x000000000040116e <+46>:    mov    ecx,eax                  ; ecx := eax = explain_me(b-2)
   0x0000000000401170 <+48>:    mov    eax,DWORD PTR [rbp-0xc]  ; eax := c
   0x0000000000401173 <+51>:    add    eax,ecx                  ; eax := c + ecx = explain_me(b-1) + explain_me(b-2)
   0x0000000000401175 <+53>:    mov    DWORD PTR [rbp-0x4],eax  ; a = eax = explain_me(b-1) + explain_me(b-2)
   0x0000000000401178 <+56>:    jmp    0x40119a <explain_me+90> ; goto _end
_less_than_2:
   0x000000000040117d <+61>:    cmp    DWORD PTR [rbp-0x8],0x1  ; if (b != 1)
   0x0000000000401181 <+65>:    jne    0x401193 <explain_me+83> ;   goto _zero
   0x0000000000401187 <+71>:    mov    DWORD PTR [rbp-0x4],0x1  ; a = 1
   0x000000000040118e <+78>:    jmp    0x40119a <explain_me+90> ; goto _end
_zero:
   0x0000000000401193 <+83>:    mov    DWORD PTR [rbp-0x4],0x0  ; a = 0
_end:
   0x000000000040119a <+90>:    mov    eax,DWORD PTR [rbp-0x4]  ; return a;
   0x000000000040119d <+93>:    add    rsp,0x10                 ;
   0x00000000004011a1 <+97>:    pop    rbp
   0x00000000004011a2 <+98>:    ret
; End of assembler dump.
