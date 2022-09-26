library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Basic NOT-gate.
entity not1 is
  port(
    in1: in std_logic;
    out1: out std_logic
  );
end;

architecture behavior of not1 is
begin
  out1 <= not in1;
end;
