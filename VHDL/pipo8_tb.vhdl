library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the PIPO (8-Bit).
entity pipo8_tb is
end pipo8_tb;

architecture test of pipo8_tb is
component pipo8 is
port(
	in1: in std_logic_vector(7 downto 0);
	-- Synchronous Reset/Set (0 : Reset, 1: Set).
	rs: in std_logic;
	clk: in std_logic;
	out1: out std_logic_vector(7 downto 0)
);
end component;

  constant T : time := 20 ns;
  signal in1, out1 : std_logic_vector(7 downto 0);
  signal rs, clk : std_logic;
begin
  pipo8_test : pipo8 port map(in1, rs, clk, out1);
  
  -- Tests all input configurations.
  process begin
    report "Start -> Test PIPO 8-Bit.";
	
	rs <= '1';
	in1 <= "00000000";
	clk <= '0';
	wait for T/2;
	clk <= '1';
	wait for T/2;
	assert(out1 = "00000000") report "FAILED: Initialization failed" severity error;
	wait for T/2;
	clk <= '0';
	wait for T/2;
	
	for i in integer range 1 to 2**8-1 loop
	  in1 <= std_logic_vector(to_unsigned(i, 8));
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i-1, 8))) report "FAILED: The output changed although no rising edge occurred (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '1';
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i, 8))) report "FAILED: The output did not change although a rising edge occurred (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '0';
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i, 8))) report "FAILED: The output changed although no rising edge occurred (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  rs <= '0';
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i, 8))) report "FAILED: The change of rs changed the output although no rising edge occurred (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '1';
	  wait for 1 ns;
      assert(out1 = "00000000") report "FAILED: The output should have been reset to 0 (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  rs <= '1';
	  wait for T/2;
	  clk <= '0';
	  wait for T/2;
	  clk <= '1';
	  wait for T/2;
	  assert(out1 = std_logic_vector(to_unsigned(i, 8))) report "FAILED: Restoration failed (Input: " & INTEGER'IMAGE(i) & ")" severity error;
	  wait for T/2;
		
	  clk <= '0';
	  wait for T/2;
	end loop;
		
	report "End -> Test PIPO 8-Bit.";
	wait;
  end process;
end test;