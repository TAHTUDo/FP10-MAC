library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the twos complement generator (8-Bit).
entity complementer8_tb is
end complementer8_tb;

architecture test of complementer8_tb is
  component complementer8 is
	port(
	  in1: in std_logic_vector(7 downto 0);
	  out1: out std_logic_vector(7 downto 0)
	);
  end component;

  constant T : time := 20 ns;
  signal in1, out1 : std_logic_vector(7 downto 0);
begin
  complementer8_test : complementer8 port map(in1, out1);
	
  -- Tests all input configurations.
  process begin
	report "Start -> Test complementer 8-Bit.";
		
	for i in integer range 0 to 2**8-1 loop
	  in1 <= std_logic_vector(to_unsigned(i, 8));
	  wait for T/2;
	  assert(out1 = std_logic_vector(unsigned(not(in1))+1)) report "FAILED: Result " & INTEGER'IMAGE(to_integer(signed(out1))) & " incorrect with Input " & INTEGER'IMAGE(to_integer(signed(in1))) severity error;
	  wait for T/2;
	end loop;
		
	report "End -> Test complementer 8-Bit.";
	wait;
  end process;
end test;