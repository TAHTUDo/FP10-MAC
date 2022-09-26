library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the basic OR-Gate (2-Bit).
entity or2_tb is
end or2_tb;

architecture test of or2_tb is
  component or2 is
    port(
      in1: in std_logic;
      in2: in std_logic;
      out1: out std_logic
    );
  end component or2;
  
  constant T : time := 20 ns;
  signal in1, in2, out1: std_logic := '0';
begin
  or2_test : or2 port map(in1, in2, out1);

  -- Tests all input configurations.
  process begin
    report "Start -> Test OR-gate 2-Bit.";
	
    in1 <= '0';
    in2 <= '0';
	wait for T/2;
    assert(out1 = '0') report "FAILED: Output must be 0 with Input 0, 0" severity error;
    wait for T/2;

    in1 <= '0';
    in2 <= '1';
	wait for T/2;
	assert(out1 = '1') report "FAILED: Output must be 1 with Input 0, 1" severity error;
    wait for T/2;

    in1 <= '1';
    in2 <= '0';
	wait for T/2;
	assert(out1 = '1') report "FAILED: Output must be 1 with Input 1, 0" severity error;
    wait for T/2;

    in1 <= '1';
    in2 <= '1';
	wait for T/2;
	assert(out1 = '1') report "FAILED: Output must be 1 with Input 1, 1" severity error;
    wait for T/2;
		
	report "End -> Test OR-gate 2-Bit.";
	wait;
  end process;
end test;
