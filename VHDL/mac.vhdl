library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- MAC-Unit, stand alone synchronized arithmetic unit to perform a multiply and accumulate command
-- where acc = acc + a * b. It has two 8-Bit input register for the two factors (a, b) and one
-- 16-Bit register for the accumulator (acc). The set and reset of those registers can be controlled
-- from outside the unit via the respective infaces. After one application (one clock cycle) two
-- dedicated outputs indicate weather an overflow (+ (+) + = -) or an underflow (- (+) - = +) occurred. 
entity mac is
  port(
    in1: in std_logic_vector(7 downto 0);
	in2: in std_logic_vector(7 downto 0);
	in3: in std_logic_vector(15 downto 0);
	clk: in std_logic;
	sel: in std_logic;
	s: in std_logic;
	r: in std_logic;
	underflow: out std_logic;
    overflow: out std_logic;
	acc: out std_logic_vector(15 downto 0)
  );
end;

architecture behavior of mac is
  component pipo8 is
    port(
      in1: in std_logic_vector(7 downto 0);
	  -- Synchronous Reset/Set (0 : Reset, 1: Set).
      rs: in std_logic;
	  clk: in std_logic;
      out1: out std_logic_vector(7 downto 0)
    );
  end component;
  
  component dadda_reducer is
    port(
      in1: in std_logic_vector(7 downto 0);
	  in2: in std_logic_vector(7 downto 0);
	  in3: in std_logic_vector(15 downto 0);
	  out1: out std_logic_vector(15 downto 0);
	  out2: out std_logic_vector(15 downto 0)
    );
  end component;
  
  component brent_kung_adder16 is
    port(
      in1: in std_logic_vector(15 downto 0);
	  in2: in std_logic_vector(15 downto 0);
	  out1: out std_logic_vector(15 downto 0)
    );
  end component;
  
  component not1 is
    port(
      in1: in std_logic;
      out1: out std_logic
    );
  end component;
  
  component and2 is
    port(
      in1: in std_logic;
	  in2: in std_logic;
      out1: out std_logic
    );
  end component;
  
  component or2 is
    port(
      in1: in std_logic;
      in2: in std_logic;
      out1: out std_logic
    );
  end component;
  
  component mux2_1 is
    port(
      in1: in std_logic_vector(15 downto 0);
	  in2: in std_logic_vector(15 downto 0);
	  sel: in std_logic;
      out1: out std_logic_vector(15 downto 0)
    );
 end component;
  
  component pipo16 is
    port(
      in1: in std_logic_vector(15 downto 0);
	  -- Asynchronous Reset.
	  r: in std_logic;
	  clk: in std_logic;
      out1: out std_logic_vector(15 downto 0)
    );
  end component;
  
  component d_ff is
    port(
      in1: in std_logic;
	  clk: in std_logic;
      out1: out std_logic
    );
  end component;
  
  signal in1_register_signal: std_logic_vector(7 downto 0);
  signal in2_register_signal: std_logic_vector(7 downto 0);
  signal in3_register_signal: std_logic_vector(15 downto 0);
  signal in3_register_next: std_logic_vector(15 downto 0);
  signal dadda_result_1: std_logic_vector(15 downto 0);
  signal dadda_result_2: std_logic_vector(15 downto 0);
  signal brent_kung_result: std_logic_vector(15 downto 0);
  signal in1_register_sign: std_logic;
  signal in1_register_sign_negated: std_logic;
  signal in2_register_sign: std_logic;
  signal in2_register_sign_negated: std_logic;
  signal in3_register_sign: std_logic;
  signal in3_register_sign_negated: std_logic;
  signal brent_kung_result_sign: std_logic;
  signal brent_kung_result_sign_negated: std_logic;
  signal neg_in2_sign_in3_sign: std_logic;
  signal in2_sign_in3_sign: std_logic;
  signal in2_sign_neg_in3_sign: std_logic;
  signal neg_in2_sign_neg_in3_sign: std_logic;
  signal neg_in1_sign_neg_in2_sign_neg_in3_sign: std_logic;
  signal in1_sign_in2_sign_neg_in3_sign: std_logic;
  signal neg_in1_sign_in2_sign_in3_sign: std_logic;
  signal in1_sign_neg_in2_sign_in3_sign: std_logic;
  signal potential_underflow: std_logic;
  signal potential_overflow: std_logic;
  signal detected_underflow: std_logic;
  signal detected_overflow: std_logic;
begin
  -- Register for the two factors.
  in1_register : pipo8 port map(in1 => in1, rs => s, clk => clk, out1 => in1_register_signal);
  in2_register : pipo8 port map(in1 => in2, rs => s, clk => clk, out1 => in2_register_signal);
  -- Reduces the multiplication of the two factors and the addition of the gained result to the accumulator
  -- to a addition of two 16-Bit numbers.  
  dadda : dadda_reducer port map(in1 => in1_register_signal, in2 => in2_register_signal, in3 => in3_register_signal, out1 => dadda_result_1, out2 => dadda_result_2);
  -- Addition of the reduced multiply and accumulate problem.
  brent_kung : brent_kung_adder16 port map(in1 => dadda_result_1, in2 => dadda_result_2, out1 => brent_kung_result);
  -- Allows to select whether the accumulator should be set at the next tick or added into it.
  mux : mux2_1 port map(in1 => brent_kung_result, in2 => in3, sel => sel, out1 => in3_register_next);
  -- Register for the accumulator.
  in3_register : pipo16 port map(in1 => in3_register_next, r => r, clk => clk, out1 => in3_register_signal);
  acc <= in3_register_signal;
  
  -- Calculate overflow:
  -- For in depth information check the corresponding diagram.
  in1_register_sign <= in1_register_signal(7);
  in2_register_sign <= in2_register_signal(7);
  in3_register_sign <= in3_register_signal(15);
  brent_kung_result_sign <= brent_kung_result(15);
  in1_register_sign_negator : not1 port map(in1 => in1_register_sign, out1 => in1_register_sign_negated);
  in2_register_sign_negator : not1 port map(in1 => in2_register_sign, out1 => in2_register_sign_negated);
  in3_register_sign_negator : not1 port map(in1 => in3_register_sign, out1 => in3_register_sign_negated);
  brent_kung_result_sign_negator : not1 port map(in1 => brent_kung_result_sign, out1 => brent_kung_result_sign_negated);
  
  and_neg_in2_sign_in3_sign : and2 port map(in1 => in2_register_sign_negated, in2 => in3_register_sign, out1 => neg_in2_sign_in3_sign);
  and_in2_sign_in3_sign : and2 port map(in1 => in2_register_sign, in2 => in3_register_sign, out1 => in2_sign_in3_sign);
  and_in2_sign_neg_in3_sign : and2 port map(in1 => in2_register_sign, in2 => in3_register_sign_negated, out1 => in2_sign_neg_in3_sign);
  and_neg_in2_sign_neg_in3_sign : and2 port map(in1 => in2_register_sign_negated, in2 => in3_register_sign_negated, out1 => neg_in2_sign_neg_in3_sign);
  
  and_neg_in1_sign_neg_in2_sign_neg_in3_sign : and2 port map(in1 => in1_register_sign_negated, in2 => neg_in2_sign_neg_in3_sign, out1 => neg_in1_sign_neg_in2_sign_neg_in3_sign);
  and_in1_sign_in2_sign_neg_in3_sign : and2 port map(in1 => in1_register_sign, in2 => in2_sign_neg_in3_sign, out1 => in1_sign_in2_sign_neg_in3_sign);
  and_neg_in1_sign_in2_sign_in3_sign : and2 port map(in1 => in1_register_sign_negated, in2 => in2_sign_in3_sign, out1 => neg_in1_sign_in2_sign_in3_sign);
  and_in1_sign_neg_in2_sign_in3_sign : and2 port map(in1 => in1_register_sign, in2 => neg_in2_sign_in3_sign, out1 => in1_sign_neg_in2_sign_in3_sign);
  or_potential_underflow : or2 port map(in1 => in1_sign_neg_in2_sign_in3_sign, in2 => neg_in1_sign_in2_sign_in3_sign, out1 => potential_underflow);
  or_potential_overflow : or2 port map(in1 => in1_sign_in2_sign_neg_in3_sign, in2 => neg_in1_sign_neg_in2_sign_neg_in3_sign, out1 => potential_overflow);
  and_underflow : and2 port map(in1 => brent_kung_result_sign_negated, in2 => potential_underflow, out1 => detected_underflow);
  and_overflow : and2 port map(in1 => brent_kung_result_sign, in2 => potential_overflow, out1 => detected_overflow);
  
  -- Registers for overflow and underflow indication.
  underflow_indicator : d_ff port map(in1 => detected_underflow, clk => clk, out1 => underflow);
  overflow_indicator : d_ff port map(in1 => detected_overflow, clk => clk, out1 => overflow);
end;