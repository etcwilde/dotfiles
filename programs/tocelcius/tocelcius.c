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
    const double celcius = (atof(argv[i]) - 32) / 1.8;
    printf("%'.2f\n", celcius);
  }
  return 0;
}
