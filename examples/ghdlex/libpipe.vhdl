--! \file libpipe.vhdl      Simple pipe I/O interface for linux named pipes
-- (c) 2011, Martin Strubel <hackfin@section5.ch>
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Unsigned

--! \defgroup GHDL_Pipe  VHDL Unix Pipe interface
--! This module implements a simple Unix pipe interface by using simple
--! file I/O to externally created names pipes.
--!
--! To create a pipe or FIFO under Linux, use the mkfifo command:
--! \code mkfifo /tmp/sim_touser
--! \endcode
--! From the GHDL side, the pipe is read like a non-FIRST-FALL-THROUGH
--! FIFO. That means, you will have to assert the RX flag prior to calling
--! pipe_in() to obtain a first valid byte.

--! \example simpipe.vhdl

--! \addtogroup GHDL_Pipe
--! \{

package ghpi_pipe is
	subtype pipeflag_t is unsigned(0 to 3); --! Pipe flags array type
	constant RX  : natural := 0; --! in: Read advance, out: FIFO not empty
	constant TX  : natural := 1; --! in: Write advance, out: FIFO not full
	constant OUR : natural := 2; --! out: Overrun/Underrun error
	constant ERR : natural := 3; --! out: Generic error

	subtype pipehandle_t is integer;  --! A pipe handle

	--! Opens a pipe
	--! \param name    Filename of the pipe (must be created externally)
	--! \return        Pipe handle, or error, if < 0
	function openpipe(name: string)
		return pipehandle_t;
	attribute foreign of openpipe :
		function is "VHPIDIRECT sim_openpipe";

	--! Read data and/or check read status
	--! \param data    if flags(RX) is set, return a byte from the FIFO.
	--!                The data is only valid when a previous flags(RX) was
	--!                asserted. Otherwise, an underrun condition
	--!                flags(OUR) = '1' will occur.
	--! \param flags   in: FIFO read request (only RX bit is evaluated),
	--!                out: Data can be read when RX = '1'
	procedure pipe_in(
		handle: pipehandle_t;
		data: out unsigned(7 downto 0);
		flags : inout pipeflag_t
	);
	attribute foreign of pipe_in :
		procedure is "VHPIDIRECT sim_pipe_in";

	--! Write data and/or check write status
	--! \param data    if flags(TX) is set, write a byte to the FIFO.
	--!                If the FIFO was not ready (flags(TX) = '0'), a
	--!                FIFO overrun condition
	--!                flags(OUR) = '1' will occur.
	--! \param flags   in: FIFO write request (only TX bit is evaluated),
	--!                out: Data can be written when TX = '1'
	procedure pipe_out(
		handle: pipehandle_t;
		data: in unsigned(7 downto 0);
		flags : inout pipeflag_t
	);
	attribute foreign of pipe_out :
		procedure is "VHPIDIRECT sim_pipe_out";

	--! Close pipe. This does not remove the actual named pipe file.
	procedure closepipe(handle: pipehandle_t);
	attribute foreign of closepipe :
		procedure is "VHPIDIRECT sim_closepipe";

end package;

--! \}

package body ghpi_pipe is
	function openpipe(name: string)
		return pipehandle_t is
	begin
		assert false report "VHPI" severity failure;
	end openpipe;

	procedure pipe_in(
		handle: pipehandle_t;
		data: out unsigned(7 downto 0);
		flags : inout pipeflag_t
	) is
	begin
	end pipe_in;

	procedure pipe_out(
		handle: pipehandle_t;
		data: in unsigned(7 downto 0);
		flags : inout pipeflag_t
	) is
	begin
		assert false report "VHPI" severity failure;
	end pipe_out;

	procedure closepipe(handle: pipehandle_t) is
	begin
		assert false report "VHPI" severity failure;
	end closepipe;

end package body;
