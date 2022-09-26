library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the basic XOR-Gate (3-Bit).
entity xor3_tb is
end xor3_tb;

architecture test of xor3_tb is
  component xor3 is
    port(
      in1: in std_logic;
	  in2: in std_logic;
	  in3: in std_logic;
	  out1: out std_logic
	);
  end component xor3;

  constant T : time := 20 ns;
  signal in1, in2, in3, out1: std_logic := '0';
begin
  xor3_test : xor3 port map(in1, in2, in3, out1);
  
  -- Tests all input configurations.
  process begin
    report "Start -> Test XOR-gate 3-Bit.";
	
    in1 <= '0';
    in2 <= '0';
	in3 <= '0';
	wait for T/2;
    assert(out1 = '0') report "FAILED: Output must be 0 with Input 0, 0, 0" severity error;
    wait for T/2;

    in1 <= '0';
    in2 <= '0';
	in3 <= '1';
	wait for T/2;
    assert(out1 = '1') report "FAILED: Output must be 1 with Input 0, 0, 1" severity error;
    wait for T/2;

    in1 <= '0';
    in2 <= '1';
	in3 <= '0';
	wait for T/2;
    assert(out1 = '1') report "FAILED: Output must be 1 with Input 0, 1, 0" severity error;
    wait for T/2;

    in1 <= '0';
    in2 <= '1';
	in3 <= '1';
	wait for T/2;
    assert(out1 = '0') report "FAILED: Output must be 0 with Input 0, 1, 1" severity error;
    wait for T/2;
	
	in1 <= '1';
    in2 <= '0';
	in3 <= '0';
	wait for T/2;
    assert(out1 = '1') report "FAILED: Output must be 1 with Input 1, 0, 0" severity error;
    wait for T/2;
	
	in1 <= '1';
    in2 <= '0';
	in3 <= '1';
	wait for T/2;
    assert(out1 = '0') report "FAILED: Output must be 0 with Input 1, 0, 1" severity error;
    wait for T/2;
	
	in1 <= '1';
    in2 <= '1';
	in3 <= '0';
	wait for T/2;
    assert(out1 = '0') report "FAILED: Output must be 0 with Input 1, 1, 0" severity error;
    wait for T/2;
	
	in1 <= '1';
    in2 <= '1';
	in3 <= '1';
	wait for T/2;
    assert(out1 = '1') report "FAILED: Output must be 1 with Input 1, 1, 1" severity error;
    wait for T/2;
		
	report "End -> Test XOR-gate 3-Bit.";
	wait;
  end process;
end test;