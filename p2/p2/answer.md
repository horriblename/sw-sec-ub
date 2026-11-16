# Aufgabe 1

1. in vuln(), the read() size is 32 bytes more than `buf`. `buf` is stored at
   ebp-0x94. To do a buffer overflow, we fill ebp-0x94 to ebp-4 (exclusive) with
   arbitrary data. ebp-4 contains the 4-byte return address, which we overwrite
   with our target address. So, we should write 0x98 bytes of data followed by
   the target return address.

# Aufgabe 2

1. `interact()` takes a `char* buf` to write to, but never checks that
   user-entered `length` <= the allocated size of buf. The `fgets` call can
   overflow the buffer. Inputting length > 96 bytes, and then any input >= 96
   bytes will cause an overflow.

# Aufgabe 3

1. In `vuln()`, the `read()` size is 32 bytes more than `sizeof(buf)`. Entering
   a normal line < 128 bytes (for the `read()` in main()), then an input of more
   than 32 bytes causes a buffer overflow.

# Aufgabe 4

1. In `real_main()`, `cmd` has 24 bytes, only the first byte used for
   determining the command, so we get 23 bytes where we can write our shell
   code. In `load_real()`, the `fgets()` size is 48 instead of the 32 bytes of
   `buf`. In the actual asm, `buf` gets 40 bytes, so we have the final 8 bytes
   to overwrite the return address to our first-stage shell code.

2. in `real_main()`, our 23-byte buffer will contain code to:
   - stack-allocate enough space for second sc
   - read from stdin the second (assembled) sc, into our allocated space
   - jump to second shell code
