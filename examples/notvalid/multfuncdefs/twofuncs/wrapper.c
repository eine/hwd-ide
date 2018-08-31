#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <stdint.h>

extern int ghdl_main (int argc, char **argv);

static int32_t *p = 0;
const uint32_t x = 10;

int mmap_ghdl_main() {
  char *argv[0];
  ghdl_main(0, argv);
}

int main(int argc, char **argv) {
  p = (int32_t*) mmap(0, x * 4, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
  if ((int*)p == (int*)-1) {
    perror("execution of mmap() failed!\n");
    return 0;
  }

  mmap_ghdl_main();

  munmap(p, x * 4);
  return 0;
}

uint64_t get_p(uint32_t w) {
  uint64_t o = 0;
  switch(w) {
    case 0 : o = (uint64_t)p; break;
    case 1 : o = x; break;
  }
  printf("get_p(%d): %lx\n", w, o);
  return o;
}

uint64_t get_m(uint32_t w) {
  printf("get_m(%d): %lx\n", w, p);
  return (uint64_t)p;
}
