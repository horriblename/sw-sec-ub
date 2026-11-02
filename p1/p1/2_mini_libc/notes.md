# Aufgabe 2

3. ```
   while (cond) {
       body;
   }
   ```

   is implemented in assembly as:

   ```
   _while_cond:
       ...
       je _while_end ; or some other conditional jump
   _while_body:
       ; body
       jmp _while_cond
   _while_end:
   ```

4. A C string is terminated by a null terminator '\0'. To find the length, we
   count the number of bytes from start of string to the null-terminator
   (excluding null-terminator).
