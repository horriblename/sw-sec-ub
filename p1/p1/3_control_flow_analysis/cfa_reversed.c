/************************************
 * Lecture Secure Software Systems
 * University of Duisburg-Essen
 *
 * https://www.syssec.wiwi.uni-due.de
 ************************************/

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// Fibonacci sequence
// assuming 32-bit int
int explain_me(int x) {
  int a, b, c, d;
  b = x;
  if (b >= 2) {
    c = explain_me(b - 1);
    // ecx := explain_me(b-2);
    a = c + explain_me(b - 2);
  } else { // b < 2
    if (b == 1) {
      a = 0;
    } else {
      a = 1;
    }
  }

  return a;
}

int main(int argc, char *argv[]) {
  if (argc == 2) {
    printf("%i\n", explain_me(atoi(argv[1])));
  } else {
    printf("usage: %s <arg>(int)\n", argv[0]);
  }
  return 0;
}
