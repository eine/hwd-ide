-- file : lfsr2.vhdl
-- parameterised LFSR generator with 2 factors
-- table from http://www.physics.otago.ac.nz/px/research/
--    electronics/papers/technical-reports/lfsr_table.pdf
-- by Roy Ward, Tim Molteno, "Table of Linear Feedback Shift Registers"
-- version oct. 8 01:09:20 CEST 2010
-- Copyright (C) 2010 Yann GUIDON
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

library ieee;
use ieee.std_logic_1164.all;

entity lfsr2 is
  generic(
    size : integer := 7); -- default size
  port(
    -- control pins
    clk, reset, din : in std_logic := '0';
    -- all the bits from the shift register are available
    lfsr : inout std_ulogic_vector(size downto 1);
    -- leave "open" or connect to a constant only :
    init_val : in std_ulogic_vector(size downto 1) := (1=>'1', others=>'0');
    -- dedicated output :
    s : out std_logic );
end lfsr2;

architecture fibonacci of lfsr2 is
  type poly_array_type is array(2 to 785) of integer;
  constant poly2_array : poly_array_type := (
  2=>1,     3=>2,     4=>3,     5=>3,     6=>5,     7=>6,     9=>5,    10=>7, 
 11=>9,    15=>14,   17=>14,   18=>11,   20=>17,   21=>19,   22=>21,   23=>18, 
 25=>22,   28=>25,   29=>27,   31=>28,   33=>20,   35=>33,   36=>25,   39=>35, 
 41=>38,   47=>42,   49=>40,   52=>49,   55=>31,   57=>50,   58=>39,   60=>59, 
 63=>62,   65=>47,   68=>59,   71=>65,   73=>48,   79=>70,   81=>77,   84=>71, 
 87=>74,   89=>51,   93=>91,   94=>73,   95=>84,   97=>91,   98=>87,  100=>63, 
103=>94,  105=>89,  106=>91,  108=>77,  111=>101, 113=>104, 118=>85,  119=>111, 
121=>103, 123=>121, 124=>87,  127=>126, 129=>124, 130=>127, 132=>103, 134=>77, 
135=>124, 137=>116, 140=>111, 142=>121, 145=>93,  148=>121, 150=>97,  151=>148, 
153=>152, 159=>128, 161=>143, 167=>161, 169=>135, 170=>147, 172=>165, 174=>161, 
175=>169, 177=>169, 178=>91,  183=>127, 185=>161, 191=>182, 193=>178, 194=>107,
198=>133, 199=>165, 201=>187, 202=>147, 207=>164, 209=>203, 212=>107, 215=>192,
217=>172, 218=>207, 223=>190, 225=>193, 231=>205, 233=>159, 234=>203, 236=>231,
239=>203, 241=>171, 247=>165, 249=>163, 250=>147, 252=>185, 255=>203, 257=>245,
258=>175, 263=>170, 265=>223, 266=>219, 268=>243, 270=>217, 271=>213, 273=>250,
274=>207, 278=>273, 279=>274, 281=>188, 282=>247, 284=>165, 286=>217, 287=>216,
289=>268, 292=>195, 294=>233, 295=>247, 297=>292, 300=>293, 302=>261, 305=>203,
313=>234, 314=>299, 316=>181, 319=>283, 321=>290, 322=>255, 327=>293, 329=>279,
332=>209, 333=>331, 337=>282, 342=>217, 343=>268, 345=>323, 350=>297, 351=>317,
353=>284, 359=>291, 362=>299, 364=>297, 366=>337, 367=>346, 369=>278, 370=>231,
375=>359, 377=>336, 378=>335, 380=>333, 382=>301, 383=>293, 385=>379, 386=>303,
390=>301, 391=>363, 393=>386, 394=>259, 396=>371, 399=>313, 401=>249, 404=>215,
406=>249, 407=>336, 409=>322, 412=>265, 415=>313, 417=>310, 422=>273, 423=>398,
425=>413, 428=>323, 431=>311, 433=>400, 436=>271, 438=>373, 439=>390, 441=>410,
446=>341, 447=>374, 449=>315, 450=>371, 455=>417, 457=>441, 458=>255, 460=>399,
462=>389, 463=>370, 465=>406, 470=>321, 471=>470, 474=>283, 476=>461, 478=>357,
479=>375, 481=>343, 484=>379, 487=>393, 489=>406, 490=>271, 494=>357, 495=>419,
497=>419, 503=>500, 505=>349, 506=>411, 508=>399, 511=>501, 513=>428, 518=>485,
519=>440, 521=>489, 524=>357, 527=>480, 529=>487, 532=>531, 537=>443, 540=>361,
543=>527, 545=>423, 550=>357, 551=>416, 553=>514, 556=>403, 559=>525, 561=>490,
564=>401, 566=>413, 567=>424, 569=>492, 570=>503, 574=>561, 575=>429, 577=>552,
582=>497, 583=>453, 585=>464, 588=>437, 590=>497, 593=>507, 594=>575, 599=>569,
601=>400, 607=>502, 609=>578, 610=>483, 615=>404, 617=>417, 622=>325, 623=>555,
625=>492, 628=>405, 631=>324, 633=>532, 634=>319, 639=>623, 641=>630, 642=>523,
646=>397, 647=>642, 649=>612, 650=>647, 652=>559, 655=>567, 657=>619, 658=>603,
662=>365, 663=>406, 665=>632, 670=>517, 671=>656, 673=>645, 676=>435, 679=>613,
686=>489, 687=>674, 689=>675, 692=>393, 695=>483, 697=>430, 698=>483, 702=>665,
705=>686, 708=>421, 711=>619, 713=>672, 714=>691, 716=>533, 719=>569, 721=>712,
722=>491, 726=>721, 727=>547, 729=>671, 730=>583, 735=>691, 737=>732, 738=>391,
740=>587, 743=>653, 745=>487, 746=>395, 751=>733, 753=>595, 754=>735, 756=>407,
759=>661, 761=>758, 762=>679, 767=>599, 769=>649, 772=>765, 774=>589, 775=>408,
777=>748, 778=>403, 782=>453, 783=>715, 785=>693, others=>0);

begin
  process (clk, reset)
  begin
    assert poly2_array(size) > 0
      report "Wrong size for LFSR2" severity failure;

    -- initialisation
    if reset = '1' then
      lfsr <= init_val;
    else
      if rising_edge(clk) then
        -- create the new bit
        lfsr(1) <= lfsr(size)
               xor lfsr(poly2_array(size))
               xor din;
        -- shift the register
        lfsr(size downto 2) <= lfsr(size-1 downto 1);
      end if;
    end if;
  end process;

  -- update the output
  s <= lfsr(1);
end fibonacci;

