/* fichier ghdl_env.c (C) Yann Guidon 2010
 version jeu. sept.  2 06:38:43 CEST 2010

ghdl_env.c : C functions that are imported in ghdl_env.vhdl
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
along with this program.  If not, see <http://www.gnu.org/licenses/>. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct int_bounds {
  int left;
  int right;
  char dir;
  unsigned int len;
};

struct ghdl_string {
  char *base;
  struct int_bounds *bounds;
};

long int ghdl_envC2(struct ghdl_string *s, int defaut) {
  char *r = getenv(s->base);
  if (r == NULL)
    return defaut;
  return atol(r);
}

extern void * __ghdl_stack2_allocate(int size);

char dumb=0;

void ghdl_env_string(struct ghdl_string *g, struct ghdl_string *s) {
  char *r =  getenv(s->base);
  struct int_bounds *b= __ghdl_stack2_allocate(sizeof(struct int_bounds));
  int l;

  if (r == NULL) {
    l=0;
    g->base = &dumb;
  }
  else {
    l=strlen(r);
    g->base = r;
  }

  g->bounds = b;
  b->left = 1;
  b->len  = b->right = l;
  b->dir  = 0;
}
