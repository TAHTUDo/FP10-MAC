library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- D-Flip-Flop (1-Bit).
entity d_ff is
  port(
    in1: in std_logic;
	clk: in std_logic;
    out1: out std_logic
  );
end;

architecture behavior of d_ff is
begin
  process (in1, clk)
  begin
    if rising_edge(clk) then
	    out1 <= in1;
    end if;
  end process;
end;