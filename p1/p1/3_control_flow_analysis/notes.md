# Aufgabe 3

1. in x86_64, System V ABI
   - Arguments go in `rdi, rsi, rdx, rcx, r8, r9`
   - Remaining arguments go on the stack in reverse order
   - callee-saved: `rbx, rsp, rbp, r12, r13, r14, r15`
   - the rest are caller saved

   There is one argument. `rdi` is read from, but `rsi`, `rdx` and so on are not
   read (`rcx` is written to before a read)

2. (cfa_dump.asm)

3. Fibonacci sequence
