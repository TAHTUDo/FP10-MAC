library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Half adder, adds two bits.
entity ha is
  port(
    in1: in std_logic;
	in2: in std_logic;
	carry: out std_logic;
    sum: out std_logic
  );
end;

architecture behavior of ha is
  component xor2 is
	port (
	  in1: in std_logic;
	  in2: in std_logic;
      out1: out std_logic
    );
  end component;
  
  component and2 is
    port(
      in1: in std_logic;
	  in2: in std_logic;
      out1: out std_logic
    );
  end component;
begin
  prop : xor2 port map(in1 => in1, in2 => in2, out1 => sum);
  gen : and2 port map(in1 => in1, in2 => in2, out1 => carry);
end;
