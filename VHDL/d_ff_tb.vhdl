library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the D-flip-flop (1-Bit).
entity d_ff_tb is
end d_ff_tb;

architecture test of d_ff_tb is
  component d_ff is
	port(
	  in1: in std_logic;
	  clk: in std_logic;
	  out1: out std_logic
	);
  end component;

  constant T : time := 20 ns;
  signal in1, clk, out1 : std_logic;
begin
  d_ff_test : d_ff port map(in1, clk, out1);
  
  -- Tests all input configurations.
  process begin
    report "Start -> Test D-flip-flop 1-Bit.";
	
	in1 <= '0';
	clk <= '0';
	wait for T/2;
	clk <= '1';
	wait for T/2;
	assert(out1 = '0') report "FAILED: Set to 0" severity error;
	wait for T/2;
	
	in1 <= '1';
	wait for T/2;
	assert(out1 = '0') report "FAILED: The change of the input changed the output although no rising edge occurred (Input: 1)" severity error;
	wait for T/2;
	clk <= '0';
	wait for T/2;
	assert(out1 = '0') report "FAILED: The change of the clock changed the output although no rising edge occurred (Input: 1)" severity error;
	wait for T/2;
	
	clk <= '1';
	wait for T/2;
	assert(out1 = '1') report "FAILED: Set to 1" severity error;
	wait for T/2;
	
	in1 <= '0';
	wait for T/2;
	assert(out1 = '1') report "FAILED: The change of the input changed the output although no rising edge occurred (Input: 0)" severity error;
	wait for T/2;
	clk <= '0';
	wait for T/2;
	assert(out1 = '1') report "FAILED: The change of the clock changed the output although no rising edge occurred (Input: 0)" severity error;
	wait for T/2;
	
	clk <= '1';
	wait for T/2;
	assert(out1 = '0') report "FAILED: Restoration failed" severity error;
	wait for T/2;

    report "End -> Test D-flip-flop 1-Bit.";
	wait;
  end process;
end test;