library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 2:1-multiplexer, allows to select one of two 16 bit numbers.
-- sel = '0' -> in1 
-- else -> in2. 
entity mux2_1 is
  port(
    in1: in std_logic_vector(15 downto 0);
	in2: in std_logic_vector(15 downto 0);
	sel: in std_logic;
    out1: out std_logic_vector(15 downto 0)
  );
end;

architecture behavior of mux2_1 is
begin
  out1 <= in1 when sel = '0'
     else in2;
end;
