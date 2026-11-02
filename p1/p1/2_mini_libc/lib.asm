; x86 asm library

global exit
global memset

global write
global read
global strlen

section .text

; void exit(int);
exit:
  ; system call number
  mov eax, 0x1
  ; load first parameter
  mov ebx, [esp + 4]
  ; perform system call
  int 0x80


; size_t write(int fd, void* buf, size_t count);
write:
  ; stack before start of proc:
  ; | count          |
  ; | buf            |
  ; | fd             |
  ; | return address | <- esp
  ; -------
  push ebp      ; callee-saved, need to restore later
  mov ebp, esp  ; ebp := esp
  push ebx      ; callee-saved

  mov eax, 0x04 ; sys_write
  mov ebx, [ebp + 8]    ; fd
  mov ecx, [ebp + 12]   ; buf
  mov edx, [ebp + 16]   ; count
  int 0x80

  pop ebx
  pop ebp
  ; -------
  ret

; size_t read(int fd, void* buf, size_t count);
read:
  ; -------
  push ebp      ; callee-saved
  mov ebp, esp  ; ebp := esp
  push ebx      ; callee-saved

  mov eax, 0x03 ; sys_read
  mov ebx, [ebp + 8]    ; fd
  mov ecx, [ebp + 12]   ; buf
  mov edx, [ebp + 16]   ; count
  int 0x80

  pop ebx
  pop ebp
  ; -------
  ret


;void* memset(void* s, int c, size_t n);
memset:
  push ebp                  ; prologue
  mov ebp, esp
  mov ecx, 0                ; initialize counter ecx with 0
  mov edx, [ebp + 8]        ; load s
  mov eax, [ebp + 12]       ; load c
_memset_loop_check:
  cmp ecx, [ebp + 16]       ; compare ecx with n
  je _memset_loop_end       ; "break" if ecx == n
_memset_loop_body:
  mov byte [edx + ecx], al  ; *(s + ecx) = c
  inc ecx                   ; ecx++
  jmp _memset_loop_check    ; eval loop condition again
_memset_loop_end:
  mov eax, [ebp + 8]        ; simply return s in eax
  mov esp, ebp              ; epilogue
  pop ebp
  ret


; unsigned int strlen(char* s);
strlen:
  push ebp
  mov ebp, esp
  push ebx  ; callee-saved register, must be restored before return
  ; -------
  mov ecx, [ebp + 8]    ; ecx: pointer to char we are now comparing
_strlen_loop_check:
  mov dl, [ecx]         ; read character at [ecx]
  cmp dl, 0             ; compare dl to 0
  je _strlen_loop_end   ; is null-terminator, stop
_strlen_loop_body:
  add ecx, 1            ; next char
  jmp _strlen_loop_check
_strlen_loop_end:
  mov eax, ecx
  sub eax, [ebp + 8]    ; len = ((char*)terminator) - ((char*)s)

  ; -------
  pop ebx
  mov esp, ebp
  pop ebp
  ret
