library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the basic AND-Gate (2-Bit).
entity and2_tb is
end and2_tb;

architecture test of and2_tb is
  component and2 is
	port(
	  in1: in std_logic;
	  in2: in std_logic;
	  out1: out std_logic
	);
  end component and2;
  
  constant T : time := 20 ns;
  signal in1, in2, out1: std_logic := '0';
begin
  and2_test : and2 port map(in1, in2, out1);
	
  -- Tests all input configurations.
  process begin
    report "Start -> Test AND-gate 2-Bit.";
	
    in1 <= '0';
    in2 <= '0';
	wait for T/2;
    assert(out1 = '0') report "FAILED: Output must be 0 with Input 0, 0" severity error;
    wait for T/2;

    in1 <= '0';
    in2 <= '1';
	wait for T/2;
	assert(out1 = '0') report "FAILED: Output must be 0 with Input 0, 1" severity error;
    wait for T/2;

    in1 <= '1';
    in2 <= '0';
	wait for T/2;
	assert(out1 = '0') report "FAILED: Output must be 0 with Input 1, 0" severity error;
    wait for T/2;

    in1 <= '1';
    in2 <= '1';
	wait for T/2;
	assert(out1 = '1') report "FAILED: Output must be 1 with Input 1, 1" severity error;
    wait for T/2;
		
	report "End -> Test AND-gate 2-Bit.";
	wait;
  end process;
end test;