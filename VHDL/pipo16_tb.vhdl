library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the PIPO (16-Bit).
entity pipo16_tb is
end pipo16_tb;

architecture test of pipo16_tb is
  component pipo16 is
	port(
	  in1: in std_logic_vector(15 downto 0);
	  -- Asynchronous Reset.
	  r: in std_logic;
	  clk: in std_logic;
	  out1: out std_logic_vector(15 downto 0)
	);
  end component;
	
  constant T : time := 20 ns;
  signal in1, out1 : std_logic_vector(15 downto 0);
  signal r, clk : std_logic;
begin
  pipo16_test : pipo16 port map(in1, r, clk, out1);
  
  -- Tests all input configurations.
  process begin
    report "Start -> Test PIPO 16-Bit.";
	
	r <= '0';
	in1 <= "0000000000000000";
	clk <= '0';
	wait for T/2;
	clk <= '1';
	wait for T/2;
	assert(out1 = "0000000000000000") report "FAILED: Initialization failed" severity error;
	wait for T/2;
	clk <= '0';
	wait for T/2;
	
	for i in integer range 1 to 2**16-1 loop
	  in1 <= std_logic_vector(to_unsigned(i, 16));
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i-1, 16))) report "FAILED: The output changed although no rising edge occurred (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '1';
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i, 16))) report "FAILED: The output did not change although a rising edge occurred (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '0';
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i, 16))) report "FAILED: The output changed although no rising edge occurred (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  r <= '1';
	  wait for T/2;
	  assert(out1 = "0000000000000000") report "FAILED: The change of r did not reset the output to 0 (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;

	  clk <= '1';
	  wait for T/2;
	  assert(out1 = "0000000000000000") report "FAILED: The output should have been reset to 0 (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '0';
	  wait for T/2;
	  r <= '0';
	  wait for T/2;
	  clk <= '1';
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i, 16))) report "FAILED: Restoration failed (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '0';
	  wait for T/2;
	end loop;
	
    report "End -> Test PIPO 16-Bit.";	
	wait;
  end process;
end test;