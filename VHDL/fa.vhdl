library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Full adder, adds three bits.
entity fa is
  port(
    in1: in std_logic;
	in2: in std_logic;
	in3: in std_logic;
	carry: out std_logic;
    sum: out std_logic
  );
end;

architecture behavior of fa is
  component ha is
	port (
	  in1: in std_logic;
	  in2: in std_logic;
	  carry: out std_logic;
      sum: out std_logic
    );
  end component;
  
  component or2 is
    port(
      in1: in std_logic;
      in2: in std_logic;
      out1: out std_logic
    );
  end component;
  
  signal carry1, sum1, carry2: std_logic;
begin
  -- Sum = (in1 XOR in2) XOR in3
  -- Carry = (in1 AND in2) OR ((in1 XOR in2) AND in3)
  ha1 : ha port map(in1 => in1, in2 => in2, carry => carry1, sum => sum1);
  ha2 : ha port map(in1 => sum1, in2 => in3, carry => carry2, sum => sum);
  or2_1 : or2 port map(in1 => carry1, in2 => carry2, out1 => carry);
end;
