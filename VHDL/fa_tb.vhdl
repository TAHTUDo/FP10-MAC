library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the full adder.
entity fa_tb is
end fa_tb;

architecture test of fa_tb is
  component fa is
    port(
      in1: in std_logic;
      in2: in std_logic;
      in3: in std_logic;
      carry: out std_logic;
      sum: out std_logic
    );
  end component;

  constant T : time := 20 ns;
  signal in1, in2, in3, carry, sum : std_logic;

begin
  fa_test : fa port map(in1 => in1, in2 => in2, in3 => in3, carry => carry, sum => sum);

  -- Tests all input configurations.
  process begin
    report "Start -> Test full adder.";
  
	in1 <= '0';
	in2 <= '0';
	in3 <= '0';
	wait for T/2;
	assert(carry = '0') report "FAILED: Carry must be 0 with Input 0, 0, 0" severity error;
	assert(sum = '0') report "FAILED: Sum must be 0 with Input 0, 0, 0" severity error;
	wait for T/2;
	
	in1 <= '0';
	in2 <= '0';
	in3 <= '1';
	wait for T/2;
	assert(carry = '0') report "FAILED: Carry must be 0 with Input 0, 0, 1" severity error;
	assert(sum = '1') report "FAILED: Sum must be 1 with Input 0, 0, 1" severity error;
	wait for T/2;
	
	in1 <= '0';
	in2 <= '1';
	in3 <= '0';
	wait for T/2;
	assert(carry = '0') report "FAILED: Carry must be 0 with Input 0, 1, 0" severity error;
	assert(sum = '1') report "FAILED: Sum must be 1 with Input 0, 1, 0" severity error;
	wait for T/2;
	
	in1 <= '0';
	in2 <= '1';
	in3 <= '1';
	wait for T/2;
	assert(carry = '1') report "FAILED: Carry must be 1 with Input 0, 1, 1" severity error;
	assert(sum = '0') report "FAILED: Sum must be 0 with Input 0, 1, 1" severity error;
	wait for T/2;
	
	in1 <= '1';
	in2 <= '0';
	in3 <= '0';
    wait for T/2;
	assert(carry = '0') report "FAILED: Carry must be 0 with Input 1, 0, 0" severity error;
	assert(sum = '1') report "FAILED: Sum must be 1 with Input 1, 0, 0" severity error;
	wait for T/2;
	
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	wait for T/2;
	assert(carry = '1') report "FAILED: Carry must be 1 with Input 1, 0, 1" severity error;
	assert(sum = '0') report "FAILED: Sum must be 0 with Input 1, 0, 1" severity error;
	wait for T/2;
	
	in1 <= '1';
	in2 <= '1';
	in3 <= '0';
	wait for T/2;
	assert(carry = '1') report "FAILED: Carry must be 1 with Input 1, 1, 0" severity error;
	assert(sum = '0') report "FAILED: Sum must be 0 with Input 1, 1, 0" severity error;
	wait for T/2;
	
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	wait for T/2;
	assert(carry = '1') report "FAILED: Carry must be 1 with Input 1, 1, 1" severity error;
	assert(sum = '1') report "FAILED: Sum must be 1 with Input 1, 1, 1" severity error;
	wait for T/2;
	
	report "End -> Test full adder.";
	wait;
  end process;
end test;
		