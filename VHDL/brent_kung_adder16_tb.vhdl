library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the Brent-Kung-adder (16-Bit).
entity brent_kung_adder16_tb is
end brent_kung_adder16_tb;

architecture test of brent_kung_adder16_tb is
  component brent_kung_adder16 is
    port(
      in1: in std_logic_vector(15 downto 0);
	  in2: in std_logic_vector(15 downto 0);
	  out1: out std_logic_vector(15 downto 0)
    );
  end component;

  constant T : time := 20 ns;
  signal in1_t : std_logic_vector(15 downto 0);
  signal in2_t : std_logic_vector(15 downto 0);
  signal out1_t : std_logic_vector(15 downto 0);
begin
  bka16 : brent_kung_adder16 port map(in1 => in1_t, in2 => in2_t, out1 => out1_t);
  
  -- Tests selected input configurations.
  -- Due to the number of different input configurations and the already performed extensive tests
  -- of the used components and the 8-Bit version, which is only sightly less complicated, only
  -- some input configurations (mainly edge cases) are tested.
  process begin
    report "Start -> Test Brent-Kung-adder 16-Bit.";
	
	-- Add (-1) and (-1) -> expected result (-2).
	in1_t <= "1111111111111111";
	in2_t <= "1111111111111111";
	wait for T/2;
	assert out1_t = "1111111111111110" report "FAILED: First term (in1): 1111111111111111, second term (in2): 1111111111111111, expected sum: 1111111111111110, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (+1) and (-1) -> expected result (0).
	in1_t <= "0000000000000001";
	in2_t <= "1111111111111111";
	wait for T/2;
	assert out1_t = "0000000000000000" report "FAILED: First term (in1): 0000000000000001, second term (in2): 1111111111111111, expected sum: 0000000000000000, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (-1) and (+1) -> expected result (0).
	in1_t <= "1111111111111111";
	in2_t <= "0000000000000001";
	wait for T/2;
	assert out1_t = "0000000000000000" report "FAILED: First term (in1): 1111111111111111, second term (in2): 0000000000000001, expected sum: 0000000000000000, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (-21846) and (0) -> expected result (-21846).
	in1_t <= "1010101010101010";
	in2_t <= "0000000000000000";
	wait for T/2;
	assert out1_t = "1010101010101010" report "FAILED: First term (in1): 1010101010101010, second term (in2): 0000000000000000, expected sum: 1010101010101010, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (-21846) and (+21845) -> expected result (-1).
	in1_t <= "1010101010101010";
	in2_t <= "0101010101010101";
	wait for T/2;
	assert out1_t = "1111111111111111" report "FAILED: First term (in1): 1010101010101010, second term (in2): 0101010101010101, expected sum: 1111111111111111, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (+16384) and (+16384) -> expected result (-32768).
	in1_t <= "0100000000000000";
	in2_t <= "0100000000000000";
	wait for T/2;
	assert out1_t = "1000000000000000" report "FAILED: First term (in1): 0100000000000000, second term (in2): 0100000000000000, expected sum: 1000000000000000, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (+18566) and (+22858) -> expected result (-24112).
	in1_t <= "0100100010000110";
	in2_t <= "0101100101001010";
	wait for T/2;
	assert out1_t = "1010000111010000" report "FAILED: First term (in1): 0100100010000110, second term (in2): 0101100101001010, expected sum: 1010000111010000, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (+18566) and (+6474) -> expected result (25040).
	in1_t <= "0100100010000110";
	in2_t <= "0001100101001010";
	wait for T/2;
	assert out1_t = "0110000111010000" report "FAILED: First term (in1): 0100100010000110, second term (in2): 0101100101001010, expected sum: 0110000111010000, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (+6) and (-6) -> expected result (0).
	in1_t <= "0000000000000110";
	in2_t <= "1111111111111010";
	wait for T/2;
	assert out1_t = "0000000000000000" report "FAILED: First term (in1): 0000000000000110, second term (in2): 1111111111111010, expected sum: 0000000000000000, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (-6) and (6) -> expected result (0).
	in1_t <= "1111111111111010";
	in2_t <= "0000000000000110";
	wait for T/2;
	assert out1_t = "0000000000000000" report "FAILED: First term (in1): 0000000000000110, second term (in2): 1111111111111010, expected sum: 0000000000000000, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	-- Add (-6) and (-6) -> expected result (-12).
	in1_t <= "1111111111111010";
	in2_t <= "1111111111111010";
	wait for T/2;
	assert out1_t = "1111111111110100" report "FAILED: First term (in1): 1111111111111010, second term (in2): 1111111111111010, expected sum: 1111111111110100, actual sum (out1): " &
	    INTEGER'IMAGE(to_integer(signed(out1_t)));
    wait for T/2;
	
	report "End -> Test Brent-Kung-adder 16-Bit.";
    wait;
  end process;
end test;