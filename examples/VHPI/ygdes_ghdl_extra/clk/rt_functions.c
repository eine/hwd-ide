/* Fichier : rt_functions.c
created by Yann Guidon / ygdes.com
jeu. avril 15 19:54:35 CEST 2010

Ce module fournit les fonctions externes de rt_clk.vhdl

Informations complementaires :
http://www.gnu.org/s/libc/manual/html_node/
 Setting-an-Alarm.html, Handler-Returns.html, Sleeping.html

test autonome :
$ gcc -DDEBUG_YG rt_functions.c -o rtf_test && ./rtf_test


rt_functions.c : real-time C functions for synchronisation of GHDL simulations
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

#include <stdio.h>
#include <signal.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

// "boite aux lettres"
volatile int compteur;

// structures a remplir pour specifier les intervalles
struct itimerval rt_itv;
struct timespec nanosleeptime;


// callback : c'est la fonction appelee periodiquement.
void timer_handler(int i) {
  compteur++;
}

void realtime_init(int ms) {
  // route le signal vers notre callback
  __sighandler_t e;
  e=signal(SIGALRM,timer_handler);
  if ((e!=SIG_IGN) && (e!=SIG_DFL)) {
    fflush(stdout);
    printf("Erreur : Signal temps réel occupé\n");
    exit(EXIT_FAILURE);
  }

  // configure les delais
  rt_itv.it_interval.tv_sec=ms / 1000;
  rt_itv.it_interval.tv_usec=(ms * 1000) % 1000000;
  rt_itv.it_value.tv_sec =rt_itv.it_interval.tv_sec;
  rt_itv.it_value.tv_usec=rt_itv.it_interval.tv_usec;

  // configure l'attente de 5ms
  nanosleeptime.tv_sec =0;
  nanosleeptime.tv_nsec=5*1000*1000;

  compteur=0;

  // lance le decompte
  setitimer(ITIMER_REAL,&rt_itv,NULL);
}

int realtime_delay(void) {
  // retour immediat sans attente :
  if (compteur!=0) {
    compteur=0;
    return 1;
  }

  // attente interruptible
  nanosleep(&nanosleeptime,NULL);

  // ne pas vider le compteur s'il est deja vide
  // (evite une race-condition stupide)
  if (compteur!=0) {
    compteur=0;
    return 1;
  }
  return 0;
}

void realtime_exit(void) {
  signal(SIGALRM,SIG_IGN);
}

#ifdef DEBUG_YG
// test autonome :
int main(int argc, char **argv) {
  int i,j=0;

  realtime_init(1000);

  for (i=0; i<10; i++) {
    j=0;
    while (0==realtime_delay())
      j++;
    printf("%d : %d\n",i,j);
  }

  realtime_exit();
  exit(EXIT_SUCCESS);
}
#endif
