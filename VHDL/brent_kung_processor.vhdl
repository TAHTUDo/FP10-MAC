library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Brent-Kung-processor, used in the Brent-Kung-adder to combine generates and propagates.
entity brent_kung_processor is
  port(
	g_1_in: in std_logic;
	p_1_in: in std_logic;
	g_2_in: in std_logic;
	p_2_in: in std_logic;
    g_out: out std_logic;
	p_out: out std_logic
  );
end;

architecture behavior of brent_kung_processor is
  component and2 is
	port(
	  in1: in std_logic;
	  in2: in std_logic;
	  out1: out std_logic
	);
  end component and2;

  component or2 is
	port(
	  in1: in std_logic;
	  in2: in std_logic;
	  out1: out std_logic
	);
  end component or2;

  signal and2_2_out1 : std_logic;
begin
  and2_1: and2 port map(p_1_in, p_2_in, p_out);
  and2_2: and2 port map(p_1_in, g_2_in, and2_2_out1);
  or2_1: or2 port map(and2_2_out1, g_1_in, g_out);
end;
