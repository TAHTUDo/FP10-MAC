library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Basic XOR-gate (3-Bit).
entity xor3 is
  port(
    in1: in std_logic;
	in2: in std_logic;
	in3: in std_logic;
    out1: out std_logic
  );
end;

architecture behavior of xor3 is
begin
  out1 <= in1 xor in2 xor in3;
end;

