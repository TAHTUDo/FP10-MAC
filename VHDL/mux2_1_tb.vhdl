library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the 2:1-MUX (16-Bit).
entity mux2_1_tb is
end mux2_1_tb;

architecture test of mux2_1_tb is
  component mux2_1 is
	port(
	  in1: in std_logic_vector(15 downto 0);
	  in2: in std_logic_vector(15 downto 0);
	  sel: in std_logic;
	  out1: out std_logic_vector(15 downto 0)
	);
  end component;
	
  constant T : time := 20 ns;
  signal in1, in2, out1 : std_logic_vector(15 downto 0);
  signal sel : std_logic;
begin
  mux2_1_test : mux2_1 port map(in1, in2, sel, out1);
  
  process begin
    report "Start -> Test 2:1-MUX.";
  
    in1 <= "0111111111111111";
    in2 <= "1111111111111111";
    sel <= '0';
    wait for T/2;
    assert(out1 = "0111111111111111") report "FAILED: The output does not match the first input" severity error;
    wait for T/2;
	
    sel <= '1';
    wait for T/2;
    assert(out1 = "1111111111111111") report "FAILED: The output does not match the second input" severity error;
    wait for T/2;
	
	report "End -> Test 2:1-MUX.";
    wait;
  end process;
end test;