#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern void ghdl_mm(uint32_t *A, uint32_t l);

int main(int argc, char **argv) {
  uint32_t l = 20;

  uint32_t *A = (uint32_t *) malloc(l*sizeof(uint32_t));
  if ( A == NULL ) {
    perror("execution of malloc() failed!\n");
    return 0;
  }

  printf("> Call 'ghdl_mm'\n");
  ghdl_mm(A,l);

  free(A);

  return 0;
}
