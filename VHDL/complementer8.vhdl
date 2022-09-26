library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Forms the twos complement of a given 8 bit number.
entity complementer8 is
  port(
    in1: in std_logic_vector(7 downto 0);
	out1: out std_logic_vector(7 downto 0)
  );
end;

architecture behavior of complementer8 is
  component fa is
    port(
      in1: in std_logic;
	  in2: in std_logic;
	  in3: in std_logic;
	  carry: out std_logic;
      sum: out std_logic
    );
  end component;
  
  component brent_kung_adder8 is
    port(
      in1: in std_logic_vector(7 downto 0);
	  in2: in std_logic_vector(7 downto 0);
	  out1: out std_logic_vector(7 downto 0)
    );
  end component;
  
  component xor2 is
	port (
	  in1: in std_logic;
	  in2: in std_logic;
      out1: out std_logic
    );
  end component;
  
  signal in1_less_one: std_logic_vector(7 downto 0);
  signal c1, c2, c3, c4, c5, c6, c7: std_logic;
begin
  -- Subtracts one.
  minus_one : brent_kung_adder8 port map(in1 => in1, in2 => "11111111", out1 => in1_less_one);
  
  -- Takes ones complement.
  xor2_0 : xor2 port map(in1 => in1_less_one(0), in2 => '1', out1 => out1(0));
  xor2_1 : xor2 port map(in1 => in1_less_one(1), in2 => '1', out1 => out1(1));
  xor2_2 : xor2 port map(in1 => in1_less_one(2), in2 => '1', out1 => out1(2));
  xor2_3 : xor2 port map(in1 => in1_less_one(3), in2 => '1', out1 => out1(3));
  xor2_4 : xor2 port map(in1 => in1_less_one(4), in2 => '1', out1 => out1(4));
  xor2_5 : xor2 port map(in1 => in1_less_one(5), in2 => '1', out1 => out1(5));
  xor2_6 : xor2 port map(in1 => in1_less_one(6), in2 => '1', out1 => out1(6));
  xor2_7 : xor2 port map(in1 => in1_less_one(7), in2 => '1', out1 => out1(7));
end;
