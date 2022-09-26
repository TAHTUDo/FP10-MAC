library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Brent-Kung-adder, takes two 8 bit numbers (twos complement) and adds them together ignoring potential
-- overflows.
entity brent_kung_adder8 is
  port(
    in1: in std_logic_vector(7 downto 0);
	in2: in std_logic_vector(7 downto 0);
	out1: out std_logic_vector(7 downto 0)
  );
end;

architecture behavior of brent_kung_adder8 is
  component brent_kung_processor is
	port(
	  g_1_in: in std_logic;
	  p_1_in: in std_logic;
	  g_2_in: in std_logic;
	  p_2_in: in std_logic;
	  g_out: out std_logic;
	  p_out: out std_logic
    );
  end component brent_kung_processor;

  component ha is
    port(
      in1: in std_logic;
	  in2: in std_logic;
	  carry: out std_logic;
      sum: out std_logic
    );
  end component ha;

  component xor3 is
	port(
	  in1: in std_logic;
	  in2: in std_logic;
	  in3: in std_logic;
	  out1: out std_logic
	);
  end component xor3;

  signal c : std_logic_vector(8 downto 0);
  signal g : std_logic_vector(8 downto 1);
  signal p : std_logic_vector(8 downto 1);
  signal g_row_2 : std_logic_vector(4 downto 1);
  signal p_row_2 : std_logic_vector(4 downto 1);
  signal g_row_3 : std_logic_vector(2 downto 1);
  signal p_row_3 : std_logic_vector(2 downto 1);
  signal g_row_4 : std_logic;
  signal p_row_4 : std_logic;
  signal g_row_5 : std_logic;
  signal p_row_5 : std_logic;
  signal g_row_6 : std_logic_vector(3 downto 1);
  signal p_row_6 : std_logic_vector(3 downto 1);
begin
  -- Calculation of the carries following the Brent-Kung-adder principal.
  -- For in depth information check the corresponding diagram.
  -- Calculation of generate and propagate induced by the inputs for each significance level.
  gen_g_p: for i in 1 to 8 generate
	gen_prop_x: ha port map(in1(i-1), in2(i-1), g(i), p(i));
  end generate gen_g_p;

  -- Second level: Combination of generate and propagate first bit with second bit, third bit with fourth bit etc.
  gen_row_2: for i in 1 to 4 generate
	brent_kung_processor_x1: brent_kung_processor port map(g(2*i), p(2*i), g(2*i-1), p(2*i-1), g_row_2(i), p_row_2(i));
  end generate gen_row_2;

  -- Third level: Combination of generate and propagate first result of the second level (1,2) with the second result of the second level (3,4) and
  -- third result of the second level (5,6) with the fourth result of the second level (7,8).
  gen_row_3: for i in 1 to 2 generate
	brent_kung_processor_x2: brent_kung_processor port map(g_row_2(2*i), p_row_2(2*i), g_row_2(2*i-1), p_row_2(2*i-1), g_row_3(i), p_row_3(i));
  end generate gen_row_3;

  -- Final combinations of generate and propagate to calculate all carries.
  brent_kung_processor_x3: brent_kung_processor port map(g_row_3(2), p_row_3(2), g_row_3(1), p_row_3(1), g_row_4, p_row_4);
  
  brent_kung_processor_x4: brent_kung_processor port map(g_row_2(3), p_row_2(3), g_row_3(1), p_row_3(1), g_row_5, p_row_5);
  
  brent_kung_processor_x5: brent_kung_processor port map(g(3), p(3), g_row_2(1), p_row_2(1), g_row_6(1), p_row_6(1));
  brent_kung_processor_x6: brent_kung_processor port map(g(5), p(5), g_row_3(1), p_row_3(1), g_row_6(2), p_row_6(2));
  brent_kung_processor_x7: brent_kung_processor port map(g(7), p(7), g_row_5, p_row_5, g_row_6(3), p_row_6(3));

  -- Identification of the carries.
  c(0) <= '0';
  c(1) <= g(1);
  c(2) <= g_row_2(1);
  c(3) <= g_row_6(1);
  c(4) <= g_row_3(1);
  c(5) <= g_row_6(2);
  c(6) <= g_row_5;
  c(7) <= g_row_6(3);
  c(8) <= g_row_4;

  -- Calculation of the actual sum.
  -- i-th bit in the output = i-th bit in the first input XOR i-th bit in the second input XOR i-th carry (induced by the previous bit)
  gen_sum: for i in 0 to 7 generate
	xor3_x: xor3 port map(in1(i), in2(i), c(i), out1(i));
  end generate gen_sum;
end;
