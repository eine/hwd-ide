/* Same as random.vhdl, but in C.  */
#include <stdlib.h>
#include <stdio.h>

int
main (void)
{
  int i;

  for (i = 0; i < 10; i++)
    printf ("%d\n", rand ());
  return 0;
}
