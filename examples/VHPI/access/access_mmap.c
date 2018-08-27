#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>

static int32_t *p;
char init = 0;

uint64_t get_p() {
  if (!init) {
    p = mmap(NULL, 20, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
    if ((int*)p == (int*)-1) {
      perror("mmap() failed!\n");
      return -1;
    }
    int x;
    for (x=0; x<5; x++) {
      p[x]=x;
    }
    printf("%lx\n", p);
  }
  return *(uint64_t*)&p;
}
