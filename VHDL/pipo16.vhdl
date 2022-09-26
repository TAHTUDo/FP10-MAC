library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 16 bit parallel in, parallel out register with an asynchronous reset.
entity pipo16 is
  port(
    in1: in std_logic_vector(15 downto 0);
	-- Asynchronous Reset.
	r: in std_logic;
	clk: in std_logic;
    out1: out std_logic_vector(15 downto 0)
  );
end;

architecture behavior of pipo16 is
begin
  process (in1, r, clk)
  begin
    if r = '1' then out1 <= "0000000000000000";
	else
	  if rising_edge(clk) then
		out1 <= in1;
	  end if;
	end if;
  end process;
end;
