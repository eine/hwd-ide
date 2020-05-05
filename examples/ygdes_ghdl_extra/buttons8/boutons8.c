/* File : boutons8.c
   created : sam. oct. 30 22:31:32 CEST 2010 by whygee@f-cpu.org
   Linked to boutons8.vhdl
*/

#include <sys/io.h>

#define SULV_U  (0) /* Uninitialized   */
#define SULV_X  (1) /* Forcing Unknown */
#define SULV_0  (2) /* Forcing 0       */
#define SULV_1  (3) /* Forcing 1       */
#define SULV_Z  (4) /* High Impedance  */
#define SULV_W  (5) /* Weak Unknown    */
#define SULV_L  (6) /* Weak 0          */
#define SULV_H  (7) /* Weak 1          */
#define SULV__  (8) /* Don't care      */

void lecture_boutons8(char boutons[8]) {
  int i=0;
  unsigned short int base   = 0x378; /* Adresse des registre du port parallele */
  char t;

  outb(inb(base+2)|32, base+2); // control port : input
  t = inb(base);

  while (i<8) {
    boutons[i]=SULV_0 | (t&1);
    t >>= 1;
    i++;
  }

  // Control port is left as input to reduce current draw on the pins
}
