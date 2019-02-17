// vim:set et sw=2 ts=4 tw=72:
// Evan Wilde (c) 2018
//
// These programs aren't secure, they're just nice to have around
#include <stdio.h>
#include <stdlib.h>


const char * USAGE = "Usage: %s <temp>\n";

int main(int argc, char *argv[]) {
  if (argc < 2) {
    fprintf(stderr, USAGE, argv[0]);
  }
  for (int i = 1; i < argc; ++i) {
    const double f = (atof(argv[i]) * 1.8) + 32;
    printf("%'.2f\n", f);
  }
  return 0;
}

