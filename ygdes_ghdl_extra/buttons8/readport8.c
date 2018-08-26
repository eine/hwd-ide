/* fichier : readport8.c
   création : sam. oct. 30 11:36:23 CEST 2010 par whygee@f-cpu.org
   version Fri Mar 16 15:54:40 CET 2012 : 8 bits on data bus
   Compiler sous GNU/Linux dans le compte root avec
     $ gcc -O2 readport8.c -o readport8
   Exécuter avec :
     $ ./passport $PWD/readport8
*/
#include <sys/io.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv) {
  unsigned short int base   = 0x378; /* Adresse des registre du port parallèle */
  unsigned char tmp = inb(base+2); // control port
  outb(tmp|32, base+2);
  printf("port 0x%X = %X\n", base, inb(base));
  outb(tmp|32, base+2);

  return EXIT_SUCCESS;
}
