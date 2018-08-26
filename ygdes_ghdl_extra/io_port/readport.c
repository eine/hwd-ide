/* fichier : readport.c
   création : sam. oct. 30 11:36:23 CEST 2010 par whygee@f-cpu.org
   Compiler sous GNU/Linux avec 
     $ gcc -O2 readport.c -o readport
   Exécuter avec :
     $ ./passport $PWD/readport
*/
#include <sys/io.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv) {
  unsigned short int status = 0x379; /* Adresse du registre de status */

  printf("port 0x%X : %X\n", status, inb(status) & 0xF0);

  return EXIT_SUCCESS;
}
