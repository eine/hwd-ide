#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <stdint.h>

static int32_t *p = 0;

const uint32_t xres = 1366;
const uint32_t yres = 768;

char init = 0;

uint64_t get_p(uint32_t w) {
  switch(w) {
    case 0 :
      if ((int*)p==(int*)0) {
        p = mmap(0, xres * yres * 4, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
        if ((int*)p == (int*)-1) {
          perror("execution of mmap() failed!\n");
          return 0;
        }
      }
      return (uint64_t)p;
    case 1 :
      return xres;
    case 2 :
      return yres;
  }
  return 0;
}

void save_pixels() {
  uint8_t *i;
  i = mmap(0, xres * yres * 3, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
  if ((int*)i == (int*)-1) {
    perror("execution of mmap() failed!\n");
    return;
  }

  int x,y;
  uint32_t *q = p;
  uint8_t *j = i;
  for(y=0;y<yres;y++) {
    for(x=0;x<xres;x++) {
      int k = *q++;
      *(j++) = (k/65536) %256;
      *(j++) = (k/256) %256;
      *(j++) = k %256;
    }
  }

  FILE *f = fopen("mmap_img.raw24","w");
  fwrite(i, xres * yres, 3, f);
  fclose(f);

  munmap(i, xres * yres * 3);

}
