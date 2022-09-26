library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the half adder.
entity ha_tb is
end ha_tb;

architecture test of ha_tb is
  component ha is
    port(
      in1: in std_logic;
	  in2: in std_logic;
	  carry: out std_logic;
      sum: out std_logic
    );
  end component;

  constant T : time := 20 ns;
  signal in1, in2, carry, sum : std_logic;
begin
  ha_test : ha port map(in1, in2, carry, sum);

  -- Tests all input configurations.
  process begin
    report "Start -> Test half adder.";
	
    in1 <= '0';
	in2 <= '0';
	wait for T/2;
	assert(carry = '0') report "FAILED: Carry must be 0 with Input 0, 0" severity error;
	assert(sum = '0') report "FAILED: Sum must be 0 with Input 0, 0" severity error;
	wait for T/2;
	
	in1 <= '1';
	in2 <= '0';
	wait for T/2;
	assert(carry = '0') report "FAILED: Carry must be 0 with Input 1, 0" severity error;
	assert(sum = '1') report "FAILED: Sum must be 1 with Input 1, 0" severity error;
	wait for T/2;
	
	in1 <= '0';
	in2 <= '1';
	wait for T/2;
	assert(carry = '0') report "FAILED: Carry must be 0 with Input 0, 1" severity error;
	assert(sum = '1') report "FAILED: Sum must be 1 with Input 0, 1" severity error;
	wait for T/2;
	
	in1 <= '1';
	in2 <= '1';
	wait for T/2;
	assert(carry = '1') report "FAILED: Carry must be 1 with Input 1, 1" severity error;
	assert(sum = '0') report "FAILED: Sum must be 0 with Input 1, 1" severity error;
	wait for T/2;
	
	report "End -> Test half adder.";
	wait;
  end process;
end test;