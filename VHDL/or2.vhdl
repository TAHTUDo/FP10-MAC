library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Basic OR-gate (2-Bit).
entity or2 is
  port(
    in1: in std_logic;
    in2: in std_logic;
    out1: out std_logic
  );
end;

architecture behavior of or2 is
begin
  out1 <= in1 or in2;
end;
