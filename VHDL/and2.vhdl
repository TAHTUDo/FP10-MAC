library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Basic AND-gate (2-Bit).
entity and2 is
  port(
    in1: in std_logic;
	in2: in std_logic;
    out1: out std_logic
  );
end;

architecture behavior of and2 is
begin
  out1 <= in1 and in2;
end;
