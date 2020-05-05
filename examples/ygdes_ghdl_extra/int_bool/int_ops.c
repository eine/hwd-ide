/* fichier : int_ops.c
 creation : lun. nov.  8 14:01:47 CET 2010 par whygee@f-cpu.org
 Fournit des fonctions logiques pour les entiers dans GHDL
*/

int int_ops_xnor(int l, int r) {  return  ~(l^r); }
int int_ops_not (int l       ) {  return  ~ l;    }
int int_ops_and (int l, int r) {  return    l&r;  }
int int_ops_or  (int l, int r) {  return    l|r;  }
int int_ops_nand(int l, int r) {  return  ~(l&r); }
int int_ops_nor (int l, int r) {  return  ~(l|r); }
int int_ops_xor (int l, int r) {  return    l^r;  }
int int_ops_ror (unsigned
    int l, int r) {  return  (l>>r)|(l<<(32-r));  }
int int_ops_rol (unsigned
    int l, int r) {  return  (l<<r)|(l>>(32-r));  }
int int_ops_sll (int l, int r) {  return    l<<r; }
int int_ops_sar (int l, int r) {  return    l>>r; }
int int_ops_slr (unsigned
                 int l, int r) {  return    l>>r; }
