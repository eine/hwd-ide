/* File : boutons.c
   created : sam. oct. 30 22:31:32 CEST 2010 by whygee@f-cpu.org

C functions that is linked to boutons.vhdl
Copyright (C) 2010 Yann GUIDON

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
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

void lecture_boutons(char boutons[4]) {
  char t = (inb(0x379) ^ 0x70) & 0xF0;
  unsigned int u= SULV_0 | (SULV_0 << 8) | (SULV_0 << 16) | (SULV_0 << 24);
  if (t & 0x10) u |= 1;
  if (t & 0x20) u |= 1<<8;
  if (t & 0x80) u |= 1<<16; /* les boutons 2 et 3 sont échangés */
  if (t & 0x40) u |= 1<<24;
  *(int*)boutons = u;
}
