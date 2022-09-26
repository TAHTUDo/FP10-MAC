library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 8 bit parallel in, parallel out register with a synchronous reset/set functionality.
entity pipo8 is
  port(
    in1: in std_logic_vector(7 downto 0);
	-- Synchronous Reset/Set (0 : Reset, 1: Set).
    rs: in std_logic;
	clk: in std_logic;
    out1: out std_logic_vector(7 downto 0)
  );
end;

architecture behavior of pipo8 is
begin
  process (in1, rs, clk)
  begin
    if rising_edge(clk) then
      if rs = '0' then
	    out1 <= "00000000";
	  else
	    out1 <= in1;
	  end if;
    end if;
  end process;
end;
