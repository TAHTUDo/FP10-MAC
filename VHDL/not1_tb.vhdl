library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the basic NOT-Gate.
entity not1_tb is
end not1_tb;

architecture test of not1_tb is
  component not1 is
    port(
      in1: in std_logic;
      out1: out std_logic
    );
  end component;

  constant T : time := 20 ns;
  signal in1, out1 : std_logic;
begin
  not1_test : not1 port map(in1, out1);
  
  -- Tests all input configurations.
  process begin
    report "Start -> Test NOT-gate.";
	
    in1 <= '0';
    wait for T/2;
    assert(out1 = '1') report "FAILED: Output must be 1 with Input 0" severity error;
	wait for T/2;
	
    in1 <= '1';
    wait for T/2;
    assert(out1 = '0') report "FAILED: Output must be 0 with Input 1" severity error;
	wait for T/2;
	
	report "End -> Test NOT-gate.";
    wait;
  end process;
end test;