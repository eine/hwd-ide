// gcc xvga.c -L/usr/X11R6/lib -lX11

#include <X11/Xlib.h>
#include <string.h>

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <stdint.h>

extern int ghdl_main (int argc, char **argv);

int xvga(void);

static int32_t *p = 0;

const uint32_t xres = 1366;
const uint32_t yres = 768;

int mmap_ghdl_main() {
  printf("> mmap_ghdl_main\n");

  int argc = 3;

  char *argv[argc];
  int x;
  for (x=0; x<argc; x++) { argv[x] = (char*) malloc(20*sizeof(char)); }
  sprintf(argv[1], "-gg_x=%d", xres);
  sprintf(argv[2], "-gg_y=%d", yres);

  for (x=0; x<argc; x++) { printf("arg %d: %s\n", x, argv[x]); }

  printf("> ghdl_main\n");
  ghdl_main(argc, argv);

  for (x=0; x<argc; x++) { free(argv[x]); }
}

Display *d;

int main(int argc, char **argv) {

  // TODO make xvga optional

  xvga();

  printf("> main %d:", argc);
  int x;
  for (x=0; x<argc; x++) { printf(" %s", argv[x]); }
  printf("\n");

  // TODO parse flags: resx, resy
  //  - Allow setting a canvas smaller than the allocated screen.
  //  - Check if larger params are given

  // TODO use malloc instead of mmap

  p = mmap(0, xres * yres * 4, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
  if ((int*)p == (int*)-1) {
    perror("execution of mmap() failed!\n");
    return 0;
  }

  mmap_ghdl_main();

  XEvent e;
  while (1) {
    XNextEvent(d, &e);
      if (e.type == KeyPress)
        break;
  }

  XCloseDisplay(d);

  munmap(p, xres * yres * 4);
  p = 0;

  return 0;
}

uint64_t get_p(uint32_t w) {
  printf("get_p(%d)\n",w);
  switch(w) {
    case 0 : return (uint64_t)p;
    case 1 : return xres;
    case 2 : return yres;
  }
  return 0;
}

int s;
Window w;
Colormap scm;
GC gc;

void save_pixels() {
  uint8_t *i;
  i = mmap(0, xres * yres * 3, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
  if ((int*)i == (int*)-1) {
    perror("execution of mmap() failed!\n");
    return;
  }

  XColor c;
  int x,y;
  uint32_t *q = p;
  uint8_t *j = i;
  for(y=0;y<yres;y++) {
    for(x=0;x<xres;x++) {
      int k = *q++;
      *(j++) = (k/65536) %256;
      *(j++) = (k/256) %256;
      *(j++) = k %256;

      // TODO copy data as in draw-pixmap.c

      char str[12];
      sprintf(str, "rgb:%02x/%02x/%02x", (k/65536) %256, (k/256) %256, k %256);
      XParseColor(d, scm, str, &c);
      XAllocColor(d, scm, &c);
      XSetForeground(d, gc, c.pixel);
      XDrawPoint(d, w, gc, x, y);
    }
  }

  FILE *f = fopen("mmap_img.raw24","w");
  fwrite(i, xres * yres, 3, f);
  fclose(f);

  munmap(i, xres * yres * 3);
  i = 0;
}

int xvga(void) {
  d = XOpenDisplay(NULL);
  if (d == NULL) {
     fprintf(stderr, "Cannot open display\n");
     exit(1);
  }

  s = DefaultScreen(d);
  w = XCreateSimpleWindow(d, RootWindow(d, s), 0, 0, xres*3/4, yres*3/4, 0, BlackPixel(d, s), BlackPixel(d, s));
  XSelectInput(d, w, ExposureMask | KeyPressMask);
  XMapWindow(d, w);
  XFlush(d);

  gc = DefaultGC(d, s);
  scm = DefaultColormap(d, DefaultScreen(d));
  XEvent e;

  while (1) {
    XNextEvent(d, &e);
    if (e.type == Expose) { break; }
  }
}
