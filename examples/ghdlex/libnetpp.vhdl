--
-- This file is generated from "libnetpp.chdl"
-- Modifications will be lost, please edit "libnetpp.chdl"
--
--
-- (c) 2011 Martin Strubel <hackfin@section5.ch>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Unsigned

package ghpi_netpp is
 constant RAMBUF_SIZE : natural := (1024 * 512);

 subtype byte_t is unsigned(7 downto 0);
 subtype regaddr_t is unsigned(7 downto 0);
 subtype token_t is integer;


 subtype netpphandle_t is integer;
 subtype framebuffer_t is integer;
 subtype pixel_t is unsigned(15 downto 0);
 -- type pixarray_t is array(0 to RAMBUF_SIZE-1) of pixel_t;
 type pixarray_t is array(natural range <>) of pixel_t;

 type handle_t is access integer;

 constant VIDEOMODE_8BIT : natural := 1; --! 8 Bit grayscale
 constant VIDEOMODE_UYVY : natural := 3; --! UYVY 16 bpp mode
 constant VIDEOMODE_INDEXED : natural := 17; --! Indexed 16bit mode

 -- Some wrapper functions:

 function device_open(id: string)
  return netpphandle_t;
 function device_gettoken(h: netpphandle_t; id: string)
  return token_t;
function device_open_wrapped(id : string) return netpphandle_t;
 attribute foreign of device_open_wrapped :
  function is "VHPIDIRECT sim_device_open_wrapped";
function device_set_int(h : netpphandle_t; t : token_t; v : integer) return integer;
 attribute foreign of device_set_int :
  function is "VHPIDIRECT sim_device_set_int";
function device_gettoken_wrapped(h : netpphandle_t; id : string) return token_t;
 attribute foreign of device_gettoken_wrapped :
  function is "VHPIDIRECT sim_device_gettoken_wrapped";
procedure device_close(h : netpphandle_t);
 attribute foreign of device_close :
  procedure is "VHPIDIRECT sim_device_close";
function initfb(dev : netpphandle_t; w : integer; h : integer; buftype : integer) return framebuffer_t;
 attribute foreign of initfb :
  function is "VHPIDIRECT sim_initfb";
procedure setpixel(fb : framebuffer_t; x : integer; y : integer; pixel : pixel_t);
 attribute foreign of setpixel :
  procedure is "VHPIDIRECT sim_setpixel";
procedure setfb(fb : framebuffer_t; data : pixarray_t);
 attribute foreign of setfb :
  procedure is "VHPIDIRECT sim_setfb";
procedure updatefb(fb : framebuffer_t);
 attribute foreign of updatefb :
  procedure is "VHPIDIRECT sim_updatefb";
procedure releasefb(fb : framebuffer_t);
 attribute foreign of releasefb :
  procedure is "VHPIDIRECT sim_releasefb";
procedure regmap_read(addr : regaddr_t; data : out byte_t);
 attribute foreign of regmap_read :
  procedure is "VHPIDIRECT sim_regmap_read";
procedure regmap_write(addr : regaddr_t; data : byte_t);
 attribute foreign of regmap_write :
  procedure is "VHPIDIRECT sim_regmap_write";
procedure usleep(cycles : integer);
 attribute foreign of usleep :
  procedure is "VHPIDIRECT sim_usleep";
function get_ptr(dev : netpphandle_t) return handle_t;
 attribute foreign of get_ptr :
  function is "VHPIDIRECT sim_get_ptr";
procedure set_ptr(h : inout handle_t);
 attribute foreign of set_ptr :
  procedure is "VHPIDIRECT sim_set_ptr";
end package;
package body ghpi_netpp is
    -- The function wrapper appends a \000 character
 function device_open(id: string)
  return netpphandle_t is
  variable dev : netpphandle_t;
    begin
  dev := device_open_wrapped(id & NUL);
  if dev < 0 then
   assert false report "Failed to open netpp remote device"
    severity failure;
  end if;
  return dev;
 end device_open;
 function device_gettoken(h: netpphandle_t; id: string)
  return token_t is
    begin
  return device_gettoken_wrapped(h, id & NUL);
 end device_gettoken;
function device_open_wrapped(id : string) return netpphandle_t is
begin
 assert false report "VHPI" severity failure;
end function;
function device_set_int(h : netpphandle_t; t : token_t; v : integer) return integer is
begin
 assert false report "VHPI" severity failure;
end function;
function device_gettoken_wrapped(h : netpphandle_t; id : string) return token_t is
begin
 assert false report "VHPI" severity failure;
end function;
procedure device_close(h : netpphandle_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
function initfb(dev : netpphandle_t; w : integer; h : integer; buftype : integer) return framebuffer_t is
begin
 assert false report "VHPI" severity failure;
end function;
procedure setpixel(fb : framebuffer_t; x : integer; y : integer; pixel : pixel_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
procedure setfb(fb : framebuffer_t; data : pixarray_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
procedure updatefb(fb : framebuffer_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
procedure releasefb(fb : framebuffer_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
procedure regmap_read(addr : regaddr_t; data : out byte_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
procedure regmap_write(addr : regaddr_t; data : byte_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
procedure usleep(cycles : integer) is
begin
 assert false report "VHPI" severity failure;
end procedure;
function get_ptr(dev : netpphandle_t) return handle_t is
begin
 assert false report "VHPI" severity failure;
end function;
procedure set_ptr(h : inout handle_t) is
begin
 assert false report "VHPI" severity failure;
end procedure;
end package body;
