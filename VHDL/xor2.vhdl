library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Basic XOR-gate (2-Bit).
entity xor2 is
  port(
    in1: in std_logic;
	in2: in std_logic;
    out1: out std_logic
  );
end;

architecture behavior of xor2 is
begin
  out1 <= in1 xor in2;
end;
