library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Dadda reducer, takes two 8 bit numbers (twos complement) where the first is multiplied by the second and
-- a third 16 bit number (twos complement), which shall be added to the product. These numbers are then
-- reduced to two 16 bit numbers (twos complement) which than only need to be added to gain the desired
-- result.
entity dadda_reducer is
  port(
    in1: in std_logic_vector(7 downto 0);
	in2: in std_logic_vector(7 downto 0);
	in3: in std_logic_vector(15 downto 0);
	out1: out std_logic_vector(15 downto 0);
	out2: out std_logic_vector(15 downto 0)
  );
end;

architecture behavior of dadda_reducer is
  component and2 is
    port(
      in1: in std_logic;
	  in2: in std_logic;
      out1: out std_logic
    );
  end component;
  
  component not1 is
    port(
      in1: in std_logic;
      out1: out std_logic
    );
  end component;
  
  component complementer8 is
    port(
      in1: in std_logic_vector(7 downto 0);
	  out1: out std_logic_vector(7 downto 0)
    );
  end component;
  
  component ha is
    port(
      in1: in std_logic;
	  in2: in std_logic;
	  carry: out std_logic;
      sum: out std_logic
    );
  end component;
  
  component fa is
    port(
      in1: in std_logic;
	  in2: in std_logic;
	  in3: in std_logic;
	  carry: out std_logic;
      sum: out std_logic
    );
  end component;
  
  signal s0_row_0_mult_matrix: std_logic_vector(7 downto 0);
  signal s0_row_1_mult_matrix: std_logic_vector(7 downto 0);
  signal s0_row_2_mult_matrix: std_logic_vector(7 downto 0);
  signal s0_row_3_mult_matrix: std_logic_vector(7 downto 0);
  signal s0_row_4_mult_matrix: std_logic_vector(7 downto 0);
  signal s0_row_5_mult_matrix: std_logic_vector(7 downto 0);
  signal s0_row_6_mult_matrix: std_logic_vector(7 downto 0);
  signal s0_row_7_mult_matrix: std_logic_vector(8 downto 0);
  signal s0_row_8_mult_matrix: std_logic_vector(15 downto 0);
  signal twos_complement_in1: std_logic_vector(7 downto 0);
  signal in1_7_negated: std_logic;
  signal sign_extension: std_logic;
  signal s1_row_0_mult_matrix: std_logic_vector(15 downto 0);
  signal s1_row_1_mult_matrix: std_logic_vector(15 downto 0);
  signal s1_row_2_mult_matrix: std_logic_vector(15 downto 0);
  signal s1_row_3_mult_matrix: std_logic_vector(15 downto 0);
  signal s1_row_4_mult_matrix: std_logic_vector(15 downto 0);
  signal s1_row_5_mult_matrix: std_logic_vector(15 downto 0);
  signal s2_row_0_mult_matrix: std_logic_vector(15 downto 0);
  signal s2_row_1_mult_matrix: std_logic_vector(15 downto 0);
  signal s2_row_2_mult_matrix: std_logic_vector(15 downto 0);
  signal s2_row_3_mult_matrix: std_logic_vector(15 downto 0);
  signal s3_row_0_mult_matrix: std_logic_vector(15 downto 0);
  signal s3_row_1_mult_matrix: std_logic_vector(15 downto 0);
  signal s3_row_2_mult_matrix: std_logic_vector(15 downto 0);
  signal s4_row_0_mult_matrix: std_logic_vector(15 downto 0);
  signal s4_row_1_mult_matrix: std_logic_vector(15 downto 0);
begin
  -- Pre-Reduction.
  -- Row 0 -> AND in1 with in2(0):
  s0_col_0_in2_0_and2 : and2 port map(in1 => in1(0), in2 => in2(0), out1 => s0_row_0_mult_matrix(0));
  s0_col_1_in2_0_and2 : and2 port map(in1 => in1(1), in2 => in2(0), out1 => s0_row_0_mult_matrix(1));
  s0_col_2_in2_0_and2 : and2 port map(in1 => in1(2), in2 => in2(0), out1 => s0_row_0_mult_matrix(2));
  s0_col_3_in2_0_and2 : and2 port map(in1 => in1(3), in2 => in2(0), out1 => s0_row_0_mult_matrix(3));
  s0_col_4_in2_0_and2 : and2 port map(in1 => in1(4), in2 => in2(0), out1 => s0_row_0_mult_matrix(4));
  s0_col_5_in2_0_and2 : and2 port map(in1 => in1(5), in2 => in2(0), out1 => s0_row_0_mult_matrix(5));
  s0_col_6_in2_0_and2 : and2 port map(in1 => in1(6), in2 => in2(0), out1 => s0_row_0_mult_matrix(6));
  s0_col_7_in2_0_and2 : and2 port map(in1 => in1(7), in2 => in2(0), out1 => s0_row_0_mult_matrix(7));
  
  -- Row 1 -> AND in1 with in2(1):
  s0_col_0_in2_1_and2 : and2 port map(in1 => in1(0), in2 => in2(1), out1 => s0_row_1_mult_matrix(0));
  s0_col_1_in2_1_and2 : and2 port map(in1 => in1(1), in2 => in2(1), out1 => s0_row_1_mult_matrix(1));
  s0_col_2_in2_1_and2 : and2 port map(in1 => in1(2), in2 => in2(1), out1 => s0_row_1_mult_matrix(2));
  s0_col_3_in2_1_and2 : and2 port map(in1 => in1(3), in2 => in2(1), out1 => s0_row_1_mult_matrix(3));
  s0_col_4_in2_1_and2 : and2 port map(in1 => in1(4), in2 => in2(1), out1 => s0_row_1_mult_matrix(4));
  s0_col_5_in2_1_and2 : and2 port map(in1 => in1(5), in2 => in2(1), out1 => s0_row_1_mult_matrix(5));
  s0_col_6_in2_1_and2 : and2 port map(in1 => in1(6), in2 => in2(1), out1 => s0_row_1_mult_matrix(6));
  s0_col_7_in2_1_and2 : and2 port map(in1 => in1(7), in2 => in2(1), out1 => s0_row_1_mult_matrix(7));
  
  -- Row 2 -> AND in1 with in2(2):
  s0_col_0_in2_2_and2 : and2 port map(in1 => in1(0), in2 => in2(2), out1 => s0_row_2_mult_matrix(0));
  s0_col_1_in2_2_and2 : and2 port map(in1 => in1(1), in2 => in2(2), out1 => s0_row_2_mult_matrix(1));
  s0_col_2_in2_2_and2 : and2 port map(in1 => in1(2), in2 => in2(2), out1 => s0_row_2_mult_matrix(2));
  s0_col_3_in2_2_and2 : and2 port map(in1 => in1(3), in2 => in2(2), out1 => s0_row_2_mult_matrix(3));
  s0_col_4_in2_2_and2 : and2 port map(in1 => in1(4), in2 => in2(2), out1 => s0_row_2_mult_matrix(4));
  s0_col_5_in2_2_and2 : and2 port map(in1 => in1(5), in2 => in2(2), out1 => s0_row_2_mult_matrix(5));
  s0_col_6_in2_2_and2 : and2 port map(in1 => in1(6), in2 => in2(2), out1 => s0_row_2_mult_matrix(6));
  s0_col_7_in2_2_and2 : and2 port map(in1 => in1(7), in2 => in2(2), out1 => s0_row_2_mult_matrix(7));
  
  -- Row 3 -> AND in1 with in2(3):
  s0_col_0_in2_3_and2 : and2 port map(in1 => in1(0), in2 => in2(3), out1 => s0_row_3_mult_matrix(0));
  s0_col_1_in2_3_and2 : and2 port map(in1 => in1(1), in2 => in2(3), out1 => s0_row_3_mult_matrix(1));
  s0_col_2_in2_3_and2 : and2 port map(in1 => in1(2), in2 => in2(3), out1 => s0_row_3_mult_matrix(2));
  s0_col_3_in2_3_and2 : and2 port map(in1 => in1(3), in2 => in2(3), out1 => s0_row_3_mult_matrix(3));
  s0_col_4_in2_3_and2 : and2 port map(in1 => in1(4), in2 => in2(3), out1 => s0_row_3_mult_matrix(4));
  s0_col_5_in2_3_and2 : and2 port map(in1 => in1(5), in2 => in2(3), out1 => s0_row_3_mult_matrix(5));
  s0_col_6_in2_3_and2 : and2 port map(in1 => in1(6), in2 => in2(3), out1 => s0_row_3_mult_matrix(6));
  s0_col_7_in2_3_and2 : and2 port map(in1 => in1(7), in2 => in2(3), out1 => s0_row_3_mult_matrix(7));
  
  -- Row 4 -> AND in1 with in2(4):
  s0_col_0_in2_4_and2 : and2 port map(in1 => in1(0), in2 => in2(4), out1 => s0_row_4_mult_matrix(0));
  s0_col_1_in2_4_and2 : and2 port map(in1 => in1(1), in2 => in2(4), out1 => s0_row_4_mult_matrix(1));
  s0_col_2_in2_4_and2 : and2 port map(in1 => in1(2), in2 => in2(4), out1 => s0_row_4_mult_matrix(2));
  s0_col_3_in2_4_and2 : and2 port map(in1 => in1(3), in2 => in2(4), out1 => s0_row_4_mult_matrix(3));
  s0_col_4_in2_4_and2 : and2 port map(in1 => in1(4), in2 => in2(4), out1 => s0_row_4_mult_matrix(4));
  s0_col_5_in2_4_and2 : and2 port map(in1 => in1(5), in2 => in2(4), out1 => s0_row_4_mult_matrix(5));
  s0_col_6_in2_4_and2 : and2 port map(in1 => in1(6), in2 => in2(4), out1 => s0_row_4_mult_matrix(6));
  s0_col_7_in2_4_and2 : and2 port map(in1 => in1(7), in2 => in2(4), out1 => s0_row_4_mult_matrix(7));
  
  -- Row 5 -> AND in1 with in2(5):
  s0_col_0_in2_5_and2 : and2 port map(in1 => in1(0), in2 => in2(5), out1 => s0_row_5_mult_matrix(0));
  s0_col_1_in2_5_and2 : and2 port map(in1 => in1(1), in2 => in2(5), out1 => s0_row_5_mult_matrix(1));
  s0_col_2_in2_5_and2 : and2 port map(in1 => in1(2), in2 => in2(5), out1 => s0_row_5_mult_matrix(2));
  s0_col_3_in2_5_and2 : and2 port map(in1 => in1(3), in2 => in2(5), out1 => s0_row_5_mult_matrix(3));
  s0_col_4_in2_5_and2 : and2 port map(in1 => in1(4), in2 => in2(5), out1 => s0_row_5_mult_matrix(4));
  s0_col_5_in2_5_and2 : and2 port map(in1 => in1(5), in2 => in2(5), out1 => s0_row_5_mult_matrix(5));
  s0_col_6_in2_5_and2 : and2 port map(in1 => in1(6), in2 => in2(5), out1 => s0_row_5_mult_matrix(6));
  s0_col_7_in2_5_and2 : and2 port map(in1 => in1(7), in2 => in2(5), out1 => s0_row_5_mult_matrix(7));
  
  -- Row 6 -> AND in1 with in2(6):
  s0_col_0_in2_6_and2 : and2 port map(in1 => in1(0), in2 => in2(6), out1 => s0_row_6_mult_matrix(0));
  s0_col_1_in2_6_and2 : and2 port map(in1 => in1(1), in2 => in2(6), out1 => s0_row_6_mult_matrix(1));
  s0_col_2_in2_6_and2 : and2 port map(in1 => in1(2), in2 => in2(6), out1 => s0_row_6_mult_matrix(2));
  s0_col_3_in2_6_and2 : and2 port map(in1 => in1(3), in2 => in2(6), out1 => s0_row_6_mult_matrix(3));
  s0_col_4_in2_6_and2 : and2 port map(in1 => in1(4), in2 => in2(6), out1 => s0_row_6_mult_matrix(4));
  s0_col_5_in2_6_and2 : and2 port map(in1 => in1(5), in2 => in2(6), out1 => s0_row_6_mult_matrix(5));
  s0_col_6_in2_6_and2 : and2 port map(in1 => in1(6), in2 => in2(6), out1 => s0_row_6_mult_matrix(6));
  s0_col_7_in2_6_and2 : and2 port map(in1 => in1(7), in2 => in2(6), out1 => s0_row_6_mult_matrix(7));
  
  -- Calculate twos complement of in1.
  complementer8_in1 : complementer8 port map(in1 => in1, out1 => twos_complement_in1);
  
  -- Row 7 -> AND in1 with in2(7):
  s0_col_0_in2_7_and2 : and2 port map(in1 => twos_complement_in1(0), in2 => in2(7), out1 => s0_row_7_mult_matrix(0));
  s0_col_1_in2_7_and2 : and2 port map(in1 => twos_complement_in1(1), in2 => in2(7), out1 => s0_row_7_mult_matrix(1));
  s0_col_2_in2_7_and2 : and2 port map(in1 => twos_complement_in1(2), in2 => in2(7), out1 => s0_row_7_mult_matrix(2));
  s0_col_3_in2_7_and2 : and2 port map(in1 => twos_complement_in1(3), in2 => in2(7), out1 => s0_row_7_mult_matrix(3));
  s0_col_4_in2_7_and2 : and2 port map(in1 => twos_complement_in1(4), in2 => in2(7), out1 => s0_row_7_mult_matrix(4));
  s0_col_5_in2_7_and2 : and2 port map(in1 => twos_complement_in1(5), in2 => in2(7), out1 => s0_row_7_mult_matrix(5));
  s0_col_6_in2_7_and2 : and2 port map(in1 => twos_complement_in1(6), in2 => in2(7), out1 => s0_row_7_mult_matrix(6));
  s0_col_7_in2_7_and2 : and2 port map(in1 => twos_complement_in1(7), in2 => in2(7), out1 => s0_row_7_mult_matrix(7));
  
  -- Row 7 sign extension:
  in1_7_negator : not1 port map(in1 => in1(7), out1 => in1_7_negated);
  sign_extension_and2 : and2 port map(in1 => in1_7_negated, in2 => in2(7), out1 => sign_extension);
  s0_col_8_in2_7_and2 : and2 port map(in1 => twos_complement_in1(7), in2 => sign_extension, out1 => s0_row_7_mult_matrix(8));
  
  -- Row 8 -> in3:
  s0_row_8_mult_matrix <= in3;
  
  
  -- First reduction step.
  -- Row 0:
  s1_row_0_mult_matrix(0) <= s0_row_0_mult_matrix(0);
  s1_row_0_mult_matrix(1) <= s0_row_0_mult_matrix(1);
  s1_row_0_mult_matrix(2) <= s0_row_0_mult_matrix(2);
  s1_row_0_mult_matrix(3) <= s0_row_0_mult_matrix(3);
  s1_row_0_mult_matrix(4) <= s0_row_0_mult_matrix(4);
  s1_col_5_row_0_row_1_ha : ha port map(in1 => s0_row_0_mult_matrix(5), in2 => s0_row_1_mult_matrix(4), carry => s1_row_0_mult_matrix(6), sum => s1_row_0_mult_matrix(5));
  s1_col_6_row_0_row_1_ha : ha port map(in1 => s0_row_0_mult_matrix(6), in2 => s0_row_1_mult_matrix(5), carry => s1_row_0_mult_matrix(7), sum => s1_row_1_mult_matrix(6));
  s1_col_7_row_0_row_1_ha : ha port map(in1 => s0_row_0_mult_matrix(7), in2 => s0_row_1_mult_matrix(6), carry => s1_row_0_mult_matrix(8), sum => s1_row_1_mult_matrix(7));
  s1_col_8_row_0_row_1_row_2_fa : fa port map(in1 => s0_row_0_mult_matrix(7), in2 => s0_row_1_mult_matrix(7), in3 => s0_row_2_mult_matrix(6), carry => s1_row_0_mult_matrix(9), sum => s1_row_1_mult_matrix(8));
  s1_col_9_row_0_row_1_row_2_fa : fa port map(in1 => s0_row_0_mult_matrix(7), in2 => s0_row_1_mult_matrix(7), in3 => s0_row_2_mult_matrix(7), carry => s1_row_0_mult_matrix(10), sum => s1_row_1_mult_matrix(9));
  -- The following additions would be identical, since only sign extensions are added.
  -- Col 10:
  s1_row_0_mult_matrix(11) <= s1_row_0_mult_matrix(10);
  s1_row_1_mult_matrix(10) <= s1_row_1_mult_matrix(9);
  -- Col 11:
  s1_row_0_mult_matrix(12) <= s1_row_0_mult_matrix(10);
  s1_row_1_mult_matrix(11) <= s1_row_1_mult_matrix(9);
  -- Col 12:
  s1_row_0_mult_matrix(13) <= s1_row_0_mult_matrix(10);
  s1_row_1_mult_matrix(12) <= s1_row_1_mult_matrix(9);
  -- Col 13:
  s1_row_0_mult_matrix(14) <= s1_row_0_mult_matrix(10);
  s1_row_1_mult_matrix(13) <= s1_row_1_mult_matrix(9);
  -- Col 14:
  s1_row_0_mult_matrix(15) <= s1_row_0_mult_matrix(10);
  s1_row_1_mult_matrix(14) <= s1_row_1_mult_matrix(9);
  -- Col 15:
  s1_row_1_mult_matrix(15) <= s1_row_1_mult_matrix(9);
  
  -- Row 1:
  s1_row_1_mult_matrix(0) <= s0_row_8_mult_matrix(0);
  s1_row_1_mult_matrix(1) <= s0_row_1_mult_matrix(0);
  s1_row_1_mult_matrix(2) <= s0_row_1_mult_matrix(1);
  s1_row_1_mult_matrix(3) <= s0_row_1_mult_matrix(2);
  s1_row_1_mult_matrix(4) <= s0_row_1_mult_matrix(3);
  s1_row_1_mult_matrix(5) <= s0_row_2_mult_matrix(3);
  -- The other columns of row 1 are already set by the previous ha and fa results (see Row 0).
  
  -- Row 2:
  s1_row_2_mult_matrix(0) <= '0';
  s1_row_2_mult_matrix(1) <= s0_row_8_mult_matrix(1);
  s1_row_2_mult_matrix(2) <= s0_row_2_mult_matrix(0);
  s1_row_2_mult_matrix(3) <= s0_row_2_mult_matrix(1);
  s1_row_2_mult_matrix(4) <= s0_row_2_mult_matrix(2);
  s1_row_2_mult_matrix(5) <= s0_row_3_mult_matrix(2);
  s1_col_6_row_2_row_3_row_4_fa : fa port map(in1 => s0_row_2_mult_matrix(4), in2 => s0_row_3_mult_matrix(3), in3 => s0_row_4_mult_matrix(2), carry => s1_row_2_mult_matrix(7), sum => s1_row_2_mult_matrix(6));
  s1_col_7_row_2_row_3_row_4_fa : fa port map(in1 => s0_row_2_mult_matrix(5), in2 => s0_row_3_mult_matrix(4), in3 => s0_row_4_mult_matrix(3), carry => s1_row_2_mult_matrix(8), sum => s1_row_3_mult_matrix(7));
  s1_col_8_row_3_row_4_row_5_fa : fa port map(in1 => s0_row_3_mult_matrix(5), in2 => s0_row_4_mult_matrix(4), in3 => s0_row_5_mult_matrix(3), carry => s1_row_2_mult_matrix(9), sum => s1_row_3_mult_matrix(8));
  s1_col_9_row_3_row_4_row_5_fa : fa port map(in1 => s0_row_3_mult_matrix(6), in2 => s0_row_4_mult_matrix(5), in3 => s0_row_5_mult_matrix(4), carry => s1_row_2_mult_matrix(10), sum => s1_row_3_mult_matrix(9));
  s1_col_10_row_3_row_4_row_5_fa : fa port map(in1 => s0_row_3_mult_matrix(7), in2 => s0_row_4_mult_matrix(6), in3 => s0_row_5_mult_matrix(5), carry => s1_row_2_mult_matrix(11), sum => s1_row_3_mult_matrix(10));
  s1_col_11_row_3_row_4_row_5_fa : fa port map(in1 => s0_row_3_mult_matrix(7), in2 => s0_row_4_mult_matrix(7), in3 => s0_row_5_mult_matrix(6), carry => s1_row_2_mult_matrix(12), sum => s1_row_3_mult_matrix(11));
  s1_col_12_row_3_row_4_row_5_fa : fa port map(in1 => s0_row_3_mult_matrix(7), in2 => s0_row_4_mult_matrix(7), in3 => s0_row_5_mult_matrix(7), carry => s1_row_2_mult_matrix(13), sum => s1_row_3_mult_matrix(12));
  -- The following additions would be identical, since only sign extensions are added.
  -- Col 13:
  s1_row_2_mult_matrix(14) <= s1_row_2_mult_matrix(13);
  s1_row_3_mult_matrix(13) <= s1_row_3_mult_matrix(12);
  -- Col 14:
  s1_row_2_mult_matrix(15) <= s1_row_2_mult_matrix(13);
  s1_row_3_mult_matrix(14) <= s1_row_3_mult_matrix(12);
  -- Col 15:
  s1_row_3_mult_matrix(15) <= s1_row_3_mult_matrix(12);
  
  -- Row 3:
  s1_row_3_mult_matrix(0) <= '0';
  s1_row_3_mult_matrix(1) <= '0';
  s1_row_3_mult_matrix(2) <= s0_row_8_mult_matrix(2);
  s1_row_3_mult_matrix(3) <= s0_row_3_mult_matrix(0);
  s1_row_3_mult_matrix(4) <= s0_row_3_mult_matrix(1);
  s1_row_3_mult_matrix(5) <= s0_row_4_mult_matrix(1);
  s1_row_3_mult_matrix(6) <= s0_row_5_mult_matrix(1);
  -- The other columns of row 3 are already set by the previous ha and fa results (see Row 2).
  
  -- Row 4:
  s1_row_4_mult_matrix(0) <= '0';
  s1_row_4_mult_matrix(1) <= '0';
  s1_row_4_mult_matrix(2) <= '0';
  s1_row_4_mult_matrix(3) <= s0_row_8_mult_matrix(3);
  s1_row_4_mult_matrix(4) <= s0_row_4_mult_matrix(0);
  s1_row_4_mult_matrix(5) <= s0_row_5_mult_matrix(0);
  s1_row_4_mult_matrix(6) <= s0_row_6_mult_matrix(0);
  s1_col_7_row_5_row_6_row_7_fa : fa port map(in1 => s0_row_5_mult_matrix(2), in2 => s0_row_6_mult_matrix(1), in3 => s0_row_7_mult_matrix(0), carry => s1_row_4_mult_matrix(8), sum => s1_row_4_mult_matrix(7));
  s1_col_8_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(2), in2 => s0_row_7_mult_matrix(1), in3 => s0_row_8_mult_matrix(8), carry => s1_row_4_mult_matrix(9), sum => s1_row_5_mult_matrix(8));
  s1_col_9_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(3), in2 => s0_row_7_mult_matrix(2), in3 => s0_row_8_mult_matrix(9), carry => s1_row_4_mult_matrix(10), sum => s1_row_5_mult_matrix(9));
  s1_col_10_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(4), in2 => s0_row_7_mult_matrix(3), in3 => s0_row_8_mult_matrix(10), carry => s1_row_4_mult_matrix(11), sum => s1_row_5_mult_matrix(10));
  s1_col_11_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(5), in2 => s0_row_7_mult_matrix(4), in3 => s0_row_8_mult_matrix(11), carry => s1_row_4_mult_matrix(12), sum => s1_row_5_mult_matrix(11));
  s1_col_12_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(6), in2 => s0_row_7_mult_matrix(5), in3 => s0_row_8_mult_matrix(12), carry => s1_row_4_mult_matrix(13), sum => s1_row_5_mult_matrix(12));
  s1_col_13_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(7), in2 => s0_row_7_mult_matrix(6), in3 => s0_row_8_mult_matrix(13), carry => s1_row_4_mult_matrix(14), sum => s1_row_5_mult_matrix(13));
  s1_col_14_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(7), in2 => s0_row_7_mult_matrix(7), in3 => s0_row_8_mult_matrix(14), carry => s1_row_4_mult_matrix(15), sum => s1_row_5_mult_matrix(14));
  s1_col_15_row_6_row_7_row_8_fa : fa port map(in1 => s0_row_6_mult_matrix(7), in2 => s0_row_7_mult_matrix(8), in3 => s0_row_8_mult_matrix(15), sum => s1_row_5_mult_matrix(15));
  
  -- Row 5:
  s1_row_5_mult_matrix(0) <= '0';
  s1_row_5_mult_matrix(1) <= '0';
  s1_row_5_mult_matrix(2) <= '0';
  s1_row_5_mult_matrix(3) <= '0';
  s1_row_5_mult_matrix(4) <= s0_row_8_mult_matrix(4);
  s1_row_5_mult_matrix(5) <= s0_row_8_mult_matrix(5);
  s1_row_5_mult_matrix(6) <= s0_row_8_mult_matrix(6);
  s1_row_5_mult_matrix(7) <= s0_row_8_mult_matrix(7);
  -- The other columns of row 5 are already set by the previous fa results (see Row 4).
  
  
  -- Second reduction step.
  -- Row 0:
  s2_row_0_mult_matrix(0) <= s1_row_0_mult_matrix(0);
  s2_row_0_mult_matrix(1) <= s1_row_0_mult_matrix(1);
  s2_row_0_mult_matrix(2) <= s1_row_0_mult_matrix(2);
  s2_col_3_row_0_row_1_ha : ha port map(in1 => s1_row_0_mult_matrix(3), in2 => s1_row_1_mult_matrix(3), carry => s2_row_0_mult_matrix(4), sum => s2_row_0_mult_matrix(3));
  s2_col_4_row_0_row_1_ha : ha port map(in1 => s1_row_0_mult_matrix(4), in2 => s1_row_1_mult_matrix(4), carry => s2_row_0_mult_matrix(5), sum => s2_row_1_mult_matrix(4));
  s2_col_5_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(5), in2 => s1_row_1_mult_matrix(5), in3 => s1_row_2_mult_matrix(5), carry => s2_row_0_mult_matrix(6), sum => s2_row_1_mult_matrix(5));
  s2_col_6_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(6), in2 => s1_row_1_mult_matrix(6), in3 => s1_row_2_mult_matrix(6), carry => s2_row_0_mult_matrix(7), sum => s2_row_1_mult_matrix(6));
  s2_col_7_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(7), in2 => s1_row_1_mult_matrix(7), in3 => s1_row_2_mult_matrix(7), carry => s2_row_0_mult_matrix(8), sum => s2_row_1_mult_matrix(7));
  s2_col_8_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(8), in2 => s1_row_1_mult_matrix(8), in3 => s1_row_2_mult_matrix(8), carry => s2_row_0_mult_matrix(9), sum => s2_row_1_mult_matrix(8));
  s2_col_9_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(9), in2 => s1_row_1_mult_matrix(9), in3 => s1_row_2_mult_matrix(9), carry => s2_row_0_mult_matrix(10), sum => s2_row_1_mult_matrix(9));
  s2_col_10_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(10), in2 => s1_row_1_mult_matrix(10), in3 => s1_row_2_mult_matrix(10), carry => s2_row_0_mult_matrix(11), sum => s2_row_1_mult_matrix(10));
  s2_col_11_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(11), in2 => s1_row_1_mult_matrix(11), in3 => s1_row_2_mult_matrix(11), carry => s2_row_0_mult_matrix(12), sum => s2_row_1_mult_matrix(11));
  s2_col_12_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(12), in2 => s1_row_1_mult_matrix(12), in3 => s1_row_2_mult_matrix(12), carry => s2_row_0_mult_matrix(13), sum => s2_row_1_mult_matrix(12));
  s2_col_13_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(13), in2 => s1_row_1_mult_matrix(13), in3 => s1_row_2_mult_matrix(13), carry => s2_row_0_mult_matrix(14), sum => s2_row_1_mult_matrix(13));
  s2_col_14_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(14), in2 => s1_row_1_mult_matrix(14), in3 => s1_row_2_mult_matrix(14), carry => s2_row_0_mult_matrix(15), sum => s2_row_1_mult_matrix(14));
  s2_col_15_row_0_row_1_row_2_fa : fa port map(in1 => s1_row_0_mult_matrix(15), in2 => s1_row_1_mult_matrix(15), in3 => s1_row_2_mult_matrix(15), sum => s2_row_1_mult_matrix(15));
  
  -- Row 1:
  s2_row_1_mult_matrix(0) <= s1_row_1_mult_matrix(0);
  s2_row_1_mult_matrix(1) <= s1_row_1_mult_matrix(1);
  s2_row_1_mult_matrix(2) <= s1_row_1_mult_matrix(2);
  s2_row_1_mult_matrix(3) <= s1_row_2_mult_matrix(3);
  -- The other columns of row 1 are already set by the previous ha and fa results (see Row 0).
  
  -- Row 2:
  s2_row_2_mult_matrix(0) <= '0';
  s2_row_2_mult_matrix(1) <= s1_row_2_mult_matrix(1);
  s2_row_2_mult_matrix(2) <= s1_row_2_mult_matrix(2);
  s2_row_2_mult_matrix(3) <= s1_row_3_mult_matrix(3);
  s2_col_4_row_2_row_3_row_4_fa : fa port map(in1 => s1_row_2_mult_matrix(4), in2 => s1_row_3_mult_matrix(4), in3 => s1_row_4_mult_matrix(4), carry => s2_row_2_mult_matrix(5), sum => s2_row_2_mult_matrix(4));
  s2_col_5_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(5), in2 => s1_row_4_mult_matrix(5), in3 => s1_row_5_mult_matrix(5), carry => s2_row_2_mult_matrix(6), sum => s2_row_3_mult_matrix(5));
  s2_col_6_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(6), in2 => s1_row_4_mult_matrix(6), in3 => s1_row_5_mult_matrix(6), carry => s2_row_2_mult_matrix(7), sum => s2_row_3_mult_matrix(6));
  s2_col_7_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(7), in2 => s1_row_4_mult_matrix(7), in3 => s1_row_5_mult_matrix(7), carry => s2_row_2_mult_matrix(8), sum => s2_row_3_mult_matrix(7));
  s2_col_8_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(8), in2 => s1_row_4_mult_matrix(8), in3 => s1_row_5_mult_matrix(8), carry => s2_row_2_mult_matrix(9), sum => s2_row_3_mult_matrix(8));
  s2_col_9_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(9), in2 => s1_row_4_mult_matrix(9), in3 => s1_row_5_mult_matrix(9), carry => s2_row_2_mult_matrix(10), sum => s2_row_3_mult_matrix(9));
  s2_col_10_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(10), in2 => s1_row_4_mult_matrix(10), in3 => s1_row_5_mult_matrix(10), carry => s2_row_2_mult_matrix(11), sum => s2_row_3_mult_matrix(10));
  s2_col_11_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(11), in2 => s1_row_4_mult_matrix(11), in3 => s1_row_5_mult_matrix(11), carry => s2_row_2_mult_matrix(12), sum => s2_row_3_mult_matrix(11));
  s2_col_12_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(12), in2 => s1_row_4_mult_matrix(12), in3 => s1_row_5_mult_matrix(12), carry => s2_row_2_mult_matrix(13), sum => s2_row_3_mult_matrix(12));
  s2_col_13_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(13), in2 => s1_row_4_mult_matrix(13), in3 => s1_row_5_mult_matrix(13), carry => s2_row_2_mult_matrix(14), sum => s2_row_3_mult_matrix(13));
  s2_col_14_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(14), in2 => s1_row_4_mult_matrix(14), in3 => s1_row_5_mult_matrix(14), carry => s2_row_2_mult_matrix(15), sum => s2_row_3_mult_matrix(14));
  s2_col_15_row_3_row_4_row_5_fa : fa port map(in1 => s1_row_3_mult_matrix(15), in2 => s1_row_4_mult_matrix(15), in3 => s1_row_5_mult_matrix(15), sum => s2_row_3_mult_matrix(15));
  
  -- Row 3:
  s2_row_3_mult_matrix(0) <= '0';
  s2_row_3_mult_matrix(1) <= '0';
  s2_row_3_mult_matrix(2) <= s1_row_3_mult_matrix(2);
  s2_row_3_mult_matrix(3) <= s1_row_4_mult_matrix(3);
  s2_row_3_mult_matrix(4) <= s1_row_5_mult_matrix(4);
  -- The other columns of row 3 are already set by the previous fa results (see Row 2).
  
  
  -- Third reduction step.
  -- Row 0:
  s3_row_0_mult_matrix(0) <= s2_row_0_mult_matrix(0);
  s3_row_0_mult_matrix(1) <= s2_row_0_mult_matrix(1);
  s3_col_2_row_0_row_1_ha : ha port map(in1 => s2_row_0_mult_matrix(2), in2 => s2_row_1_mult_matrix(2), carry => s3_row_0_mult_matrix(3), sum => s3_row_0_mult_matrix(2));
  s3_col_3_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(3), in2 => s2_row_1_mult_matrix(3), in3 => s2_row_2_mult_matrix(3), carry => s3_row_0_mult_matrix(4), sum => s3_row_1_mult_matrix(3));
  s3_col_4_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(4), in2 => s2_row_1_mult_matrix(4), in3 => s2_row_2_mult_matrix(4), carry => s3_row_0_mult_matrix(5), sum => s3_row_1_mult_matrix(4));
  s3_col_5_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(5), in2 => s2_row_1_mult_matrix(5), in3 => s2_row_2_mult_matrix(5), carry => s3_row_0_mult_matrix(6), sum => s3_row_1_mult_matrix(5));
  s3_col_6_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(6), in2 => s2_row_1_mult_matrix(6), in3 => s2_row_2_mult_matrix(6), carry => s3_row_0_mult_matrix(7), sum => s3_row_1_mult_matrix(6));
  s3_col_7_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(7), in2 => s2_row_1_mult_matrix(7), in3 => s2_row_2_mult_matrix(7), carry => s3_row_0_mult_matrix(8), sum => s3_row_1_mult_matrix(7));
  s3_col_8_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(8), in2 => s2_row_1_mult_matrix(8), in3 => s2_row_2_mult_matrix(8), carry => s3_row_0_mult_matrix(9), sum => s3_row_1_mult_matrix(8));
  s3_col_9_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(9), in2 => s2_row_1_mult_matrix(9), in3 => s2_row_2_mult_matrix(9), carry => s3_row_0_mult_matrix(10), sum => s3_row_1_mult_matrix(9));
  s3_col_10_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(10), in2 => s2_row_1_mult_matrix(10), in3 => s2_row_2_mult_matrix(10), carry => s3_row_0_mult_matrix(11), sum => s3_row_1_mult_matrix(10));
  s3_col_11_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(11), in2 => s2_row_1_mult_matrix(11), in3 => s2_row_2_mult_matrix(11), carry => s3_row_0_mult_matrix(12), sum => s3_row_1_mult_matrix(11));
  s3_col_12_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(12), in2 => s2_row_1_mult_matrix(12), in3 => s2_row_2_mult_matrix(12), carry => s3_row_0_mult_matrix(13), sum => s3_row_1_mult_matrix(12));
  s3_col_13_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(13), in2 => s2_row_1_mult_matrix(13), in3 => s2_row_2_mult_matrix(13), carry => s3_row_0_mult_matrix(14), sum => s3_row_1_mult_matrix(13));
  s3_col_14_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(14), in2 => s2_row_1_mult_matrix(14), in3 => s2_row_2_mult_matrix(14), carry => s3_row_0_mult_matrix(15), sum => s3_row_1_mult_matrix(14));
  s3_col_15_row_0_row_1_row_2_fa : fa port map(in1 => s2_row_0_mult_matrix(15), in2 => s2_row_1_mult_matrix(15), in3 => s2_row_2_mult_matrix(15), sum => s3_row_1_mult_matrix(15));
  
  -- Row 1:
  s3_row_1_mult_matrix(0) <= s2_row_1_mult_matrix(0);
  s3_row_1_mult_matrix(1) <= s2_row_1_mult_matrix(1);
  s3_row_1_mult_matrix(2) <= s2_row_2_mult_matrix(2);
  -- The other columns of row 1 are already set by the previous ha and fa results (see Row 0).
  
  -- Row 2:
  s3_row_2_mult_matrix(0) <= '0';
  s3_row_2_mult_matrix(1) <= s2_row_2_mult_matrix(1);
  s3_row_2_mult_matrix(2) <= s2_row_3_mult_matrix(2);
  s3_row_2_mult_matrix(3) <= s2_row_3_mult_matrix(3);
  s3_row_2_mult_matrix(4) <= s2_row_3_mult_matrix(4);
  s3_row_2_mult_matrix(5) <= s2_row_3_mult_matrix(5);
  s3_row_2_mult_matrix(6) <= s2_row_3_mult_matrix(6);
  s3_row_2_mult_matrix(7) <= s2_row_3_mult_matrix(7);
  s3_row_2_mult_matrix(8) <= s2_row_3_mult_matrix(8);
  s3_row_2_mult_matrix(9) <= s2_row_3_mult_matrix(9);
  s3_row_2_mult_matrix(10) <= s2_row_3_mult_matrix(10);
  s3_row_2_mult_matrix(11) <= s2_row_3_mult_matrix(11);
  s3_row_2_mult_matrix(12) <= s2_row_3_mult_matrix(12);
  s3_row_2_mult_matrix(13) <= s2_row_3_mult_matrix(13);
  s3_row_2_mult_matrix(14) <= s2_row_3_mult_matrix(14);
  s3_row_2_mult_matrix(15) <= s2_row_3_mult_matrix(15);
  
  
  -- Fourth reduction step.
  -- Row 0:
  s4_row_0_mult_matrix(0) <= s3_row_0_mult_matrix(0);
  s4_col_1_row_0_row_1_ha : ha port map(in1 => s3_row_0_mult_matrix(1), in2 => s3_row_1_mult_matrix(1), carry => s4_row_0_mult_matrix(2), sum => s4_row_0_mult_matrix(1));
  s4_col_2_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(2), in2 => s3_row_1_mult_matrix(2), in3 => s3_row_2_mult_matrix(2), carry => s4_row_0_mult_matrix(3), sum => s4_row_1_mult_matrix(2));
  s4_col_3_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(3), in2 => s3_row_1_mult_matrix(3), in3 => s3_row_2_mult_matrix(3), carry => s4_row_0_mult_matrix(4), sum => s4_row_1_mult_matrix(3));
  s4_col_4_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(4), in2 => s3_row_1_mult_matrix(4), in3 => s3_row_2_mult_matrix(4), carry => s4_row_0_mult_matrix(5), sum => s4_row_1_mult_matrix(4));
  s4_col_5_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(5), in2 => s3_row_1_mult_matrix(5), in3 => s3_row_2_mult_matrix(5), carry => s4_row_0_mult_matrix(6), sum => s4_row_1_mult_matrix(5));
  s4_col_6_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(6), in2 => s3_row_1_mult_matrix(6), in3 => s3_row_2_mult_matrix(6), carry => s4_row_0_mult_matrix(7), sum => s4_row_1_mult_matrix(6));
  s4_col_7_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(7), in2 => s3_row_1_mult_matrix(7), in3 => s3_row_2_mult_matrix(7), carry => s4_row_0_mult_matrix(8), sum => s4_row_1_mult_matrix(7));
  s4_col_8_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(8), in2 => s3_row_1_mult_matrix(8), in3 => s3_row_2_mult_matrix(8), carry => s4_row_0_mult_matrix(9), sum => s4_row_1_mult_matrix(8));
  s4_col_9_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(9), in2 => s3_row_1_mult_matrix(9), in3 => s3_row_2_mult_matrix(9), carry => s4_row_0_mult_matrix(10), sum => s4_row_1_mult_matrix(9));
  s4_col_10_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(10), in2 => s3_row_1_mult_matrix(10), in3 => s3_row_2_mult_matrix(10), carry => s4_row_0_mult_matrix(11), sum => s4_row_1_mult_matrix(10));
  s4_col_11_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(11), in2 => s3_row_1_mult_matrix(11), in3 => s3_row_2_mult_matrix(11), carry => s4_row_0_mult_matrix(12), sum => s4_row_1_mult_matrix(11));
  s4_col_12_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(12), in2 => s3_row_1_mult_matrix(12), in3 => s3_row_2_mult_matrix(12), carry => s4_row_0_mult_matrix(13), sum => s4_row_1_mult_matrix(12));
  s4_col_13_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(13), in2 => s3_row_1_mult_matrix(13), in3 => s3_row_2_mult_matrix(13), carry => s4_row_0_mult_matrix(14), sum => s4_row_1_mult_matrix(13));
  s4_col_14_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(14), in2 => s3_row_1_mult_matrix(14), in3 => s3_row_2_mult_matrix(14), carry => s4_row_0_mult_matrix(15), sum => s4_row_1_mult_matrix(14));
  s4_col_15_row_0_row_1_row_2_fa : fa port map(in1 => s3_row_0_mult_matrix(15), in2 => s3_row_1_mult_matrix(15), in3 => s3_row_2_mult_matrix(15), sum => s4_row_1_mult_matrix(15));
  
  -- Row 1:
  s4_row_1_mult_matrix(0) <= s3_row_1_mult_matrix(0);
  s4_row_1_mult_matrix(1) <= s3_row_2_mult_matrix(1);
  -- The other columns of row 1 are already set by the previous ha and fa results (see Row 0).
  
  out1 <= s4_row_0_mult_matrix;
  out2 <= s4_row_1_mult_matrix;
end;
