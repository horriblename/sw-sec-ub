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
