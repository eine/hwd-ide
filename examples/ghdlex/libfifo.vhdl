--! \file libfifo.vhdl      I/O interface for thread controlled FIFO
-- (c) 2011, Martin Strubel <hackfin@section5.ch>
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Unsigned

--! \defgroup GHDL_Fifo  VHDL FIFO interface
--! This module implements the interface to the C software FIFO in
--! FIRST-FALL-THROUGH mode. That is, when the TXE/TX flag is asserted
--! high, valid data can be read from the 'data' channel. To advance the
--! internal read pointer, the RX flag must be asserted before
--! calling fifo_io().
--!
--! The functionality from the API side is elegant, but not trivial.
--! Have a look at the provided simfifo.vhdl example.
--!
--! \example simfifo.vhdl

--! \addtogroup GHDL_Fifo
--! \{

package ghpi_fifo is

	subtype fdata is unsigned;
	subtype fifoflag_t is unsigned(0 to 5);
	-- FIFO flag indices:
	constant RX  : natural := 0; --! in: Read advance, out: FIFO not empty
	constant TX  : natural := 1; --! in: Write advance, out: FIFO not full
	constant RXE : natural := 2; --! out: LOW when FIFO almost not empty
	constant TXF : natural := 3; --! out: LOW when FIFO almost full
	constant OVR : natural := 4; --! out: overrun bit. Write 1 to clear.
	constant UNR : natural := 5; --! out: underrun bit. W1C.

	--! Init the external FIFO thread
	function thread_init(arg: string) return integer;

	-- This is just a wrapper for the above function
	function sim_thread_init(arg: string) return integer;
	attribute foreign of sim_thread_init :
		function is "VHPIDIRECT sim_thread_init";

	--! Shutdown external FIFO thread
	procedure thread_exit;
	attribute foreign of thread_exit : procedure is "VHPIDIRECT thread_exit";

	--! The FIFO I/O routine.
	--! \param data   Pointer to data being written, if TX flag set,
	--!               Data is modified with the 'read' FIFO data when RX
	--!               flag set. If FIFO is not ready for READ or WRITE
	--!               operation (empty or full), an underrun respective
	--!               overrun condition will occur and be signalled in the
	--!               flags(OVR) and flags(UNR) bits. Clearing this error
	--!               condition is achieved by setting these error flags to
	--!               '1'.
	--! \param flags  The FIFO control (in) and status (out) flags.
	--!               When calling this function the first time, you should
	--!               check the status by setting all flags to '0'.
	--!               On return, the (RX) and (TX) fill state can be read
	--!               from the RXE and TXF flags (for burst reading) and
	--!               from the RX and TX flags (current, absolute FIFO fill
	--!               state. On subsequent calls, the RX and TX flags
	--!               indicate, which action (Read word/Write word) should
	--!               be taken. The current status is always returned in the
	--!               flags array.
	procedure fifo_io(
		data: inout fdata;
		flags : inout fifoflag_t
	);
	attribute foreign of fifo_io : procedure is
		"VHPIDIRECT sim_fifo_io";

end package;

--! \}

package body ghpi_fifo is
	function thread_init(arg: string) return integer is begin
		return sim_thread_init(arg & NUL);
	end thread_init;

	function sim_thread_init(arg: string) return integer is begin
		assert false report "VHPI" severity failure;
	end sim_thread_init;

	procedure thread_exit is begin
		assert false report "VHPI" severity failure;
	end thread_exit;

	procedure fifo_io(
		data:  inout fdata;
		flags: inout fifoflag_t
	) is
	begin
		assert false report "VHPI" severity failure;
	end fifo_io;

end package body;

