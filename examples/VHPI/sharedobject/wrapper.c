#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern int ghdl_main (int argc, char **argv);

int32_t *p = 0;
uint32_t x = 10;

uint64_t get_p(uint32_t w) {
  uint64_t o = 0;
  switch(w) {
    case 0 : o = (uint64_t)p;
    case 1 : o = x;
  }
  printf("get_p(%d): %lX\n", w, o);
  return o;
}

uint64_t get_m(uint32_t w) {
  printf("get_p(%d): %lX\n", w, p);
  return (uint64_t)p;
}

void ghdl_mm(uint32_t *A, uint32_t l) {
  printf(">> ghdl_mm\n");

  p = (int32_t*) A;
  x = l;

  printf(">> ghdl_main\n");
  char *argv[0];
  ghdl_main(0, argv);
}
