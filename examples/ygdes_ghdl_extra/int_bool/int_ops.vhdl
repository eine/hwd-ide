-- fichier : int_ops.vhdl
-- creation : lun. nov.  8 12:25:49 CET 2010 par whygee@f-cpu.org
-- Fournit les opérations booléennes aux nombres entiers dans GCC.

package int_ops is
  -- Fonctions logiques :
  function "xnor" (L, R: integer) return integer;
    attribute foreign of "xnor" : function is "VHPIDIRECT int_ops_xnor";
  function  "not" (L   : integer) return integer;
    attribute foreign of  "not" : function is "VHPIDIRECT int_ops_not";
  function  "and" (L, R: integer) return integer;
    attribute foreign of  "and" : function is "VHPIDIRECT int_ops_and";
  function   "or" (L, R: integer) return integer;
    attribute foreign of   "or" : function is "VHPIDIRECT int_ops_or";
  function "nand" (L, R: integer) return integer;
    attribute foreign of "nand" : function is "VHPIDIRECT int_ops_nand";
  function  "nor" (L, R: integer) return integer;
    attribute foreign of  "nor" : function is "VHPIDIRECT int_ops_nor";
  function  "xor" (L, R: integer) return integer;
    attribute foreign of  "xor" : function is "VHPIDIRECT int_ops_xor";

  -- Fonctions de décalage et de rotation :
  function  "ror" (L, R: integer) return integer;
    attribute foreign of  "ror" : function is "VHPIDIRECT int_ops_ror";
  function  "rol" (L, R: integer) return integer;
    attribute foreign of  "rol" : function is "VHPIDIRECT int_ops_rol";
  function  "sra" (L, R: integer) return integer;
    attribute foreign of  "sra" : function is "VHPIDIRECT int_ops_sar";
  function  "srl" (L, R: integer) return integer;
    attribute foreign of  "srl" : function is "VHPIDIRECT int_ops_slr";
  function  "sll" (L, R: integer) return integer;
    attribute foreign of  "sll" : function is "VHPIDIRECT int_ops_sll";
end int_ops;

package body int_ops is
  -- Fonctions logiques :
  function "xnor" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;


  function  "not" (L   : integer) return integer is
  begin
    assert false report "VHPI" severity failure; 
  end;

  function  "and" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function   "or" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function "nand" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function  "nor" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function  "xor" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;


  -- Fonctions de décalage et de rotation :
  function  "ror" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function  "rol" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function  "srl" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function  "sra" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

  function  "sll" (L, R: integer) return integer is
  begin
    assert false report "VHPI" severity failure;
  end;

end int_ops;

