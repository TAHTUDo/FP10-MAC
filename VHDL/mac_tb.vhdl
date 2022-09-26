library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the MAC-Unit (8-Bit * 8-Bit + 16-Bit -> 16-Bit).
entity mac_tb is
end mac_tb;

architecture test of mac_tb is
  component mac is
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
  end component;

  constant T : time := 20 ns;
  signal in1_t : std_logic_vector(7 downto 0);
  signal in2_t : std_logic_vector(7 downto 0);
  signal in3_t : std_logic_vector(15 downto 0);
  signal clk_t : std_logic := '0';
  signal sel_t : std_logic;
  signal s_t : std_logic;
  signal r_t : std_logic;
  signal underflow_t : std_logic;
  signal overflow_t : std_logic;
  signal acc_t : std_logic_vector(15 downto 0);
begin
  mac_t : mac port map(in1 => in1_t, in2 => in2_t, in3 => in3_t, clk => clk_t, sel => sel_t, s => s_t, r => r_t, underflow => underflow_t, overflow => overflow_t, acc => acc_t);
  
  -- Tests selected input configurations.
  -- Due to the number of different input configurations and the already performed extensive tests
  -- of the used components, only some input configurations (mainly edge cases) are tested.
  process begin
    report "Start test for MAC-unit.";
	
	-- Initilization.
	in1_t <= "00000000";
	in2_t <= "00000000";
	in3_t <= "0000000000000000";
	sel_t <= '0';
	s_t <= '0';
	r_t <= '1';
	clk_t <= '1';
	wait for T/2;
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	
	-- Load a = 4, b = 2, acc = 2560.
	-- Expected result: acc = 2568, no underflow, no overflow.
	in1_t <= "00000100";
	in2_t <= "00000010";
	in3_t <= "0000101000000000";
	sel_t <= '1';
	s_t <= '1';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
	s_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "0000101000001000" report "FAILED: First term (in1): 00000100, second term (in2): 00000010, third term (in3): 0000101000000000, expected result: 0000101000001000, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '0' report "FAILED: First term (in1): 00000100, second term (in2): 00000010, third term (in3): 0000101000000000, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: First term (in1): 00000100, second term (in2): 00000010, third term (in3): 0000101000000000, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Asynchronous reset.
	-- Expected result: acc = 0, no underflow, no overflow.
	r_t <= '1';
	wait for T/2;
	assert acc_t = "0000000000000000" report "FAILED: Reset (r): '1', expected result: 0000000000000000, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '0' report "FAILED: Reset (r): '1', expected result: '0', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: Reset (r): '1', expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Load a = 64, b = 64, acc = 16384.
	-- Expected result: acc = 20480, no underflow, no overflow.
	in1_t <= "01000000";
	in2_t <= "01000000";
	in3_t <= "0100000000000000";
	sel_t <= '1';
	s_t <= '1';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
	s_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "0101000000000000" report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 0100000000000000, expected result: 0101000000000000, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '0' report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 0100000000000000, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 0100000000000000, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Load a = 64, b = 64, acc = 28672.
	-- Expected result: acc = -32768, no underflow, overflow.
	in1_t <= "01000000";
	in2_t <= "01000000";
	in3_t <= "0111000000000000";
	sel_t <= '1';
	s_t <= '1';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
	s_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "1000000000000000" report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 0100000000000000, expected result: 1000000000000000, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '0' report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 0100000000000000, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '1' report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 0100000000000000, expected result: '1', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Load a = 64, b = 64, acc = -1.
	-- Expected result: acc = 4095, no underflow, no overflow.
	in1_t <= "01000000";
	in2_t <= "01000000";
	in3_t <= "1111111111111111";
	sel_t <= '1';
	s_t <= '1';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
	s_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "0000111111111111" report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 1111111111111111, expected result: 0000111111111111, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '0' report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 1111111111111111, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: First term (in1): 01000000, second term (in2): 01000000, third term (in3): 1111111111111111, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Load a = 64, b = -128, acc = -32768.
	-- Expected result: acc = 24576, underflow, no overflow.
	in1_t <= "01000000";
	in2_t <= "10000000";
	in3_t <= "1000000000000000";
	sel_t <= '1';
	s_t <= '1';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
	s_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "0110000000000000" report "FAILED: First term (in1): 01000000, second term (in2): 10000000, third term (in3): 1000000000000000, expected result: 0110000000000000, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '1' report "FAILED: First term (in1): 01000000, second term (in2): 10000000, third term (in3): 1000000000000000, expected result: '1', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: First term (in1): 01000000, second term (in2): 10000000, third term (in3): 1000000000000000, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Load a = -128, b = 64, acc = -32768.
	-- Expected result: acc = 24576, underflow, no overflow.
	in1_t <= "10000000";
	in2_t <= "01000000";
	in3_t <= "1000000000000000";
	sel_t <= '1';
	s_t <= '1';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
	s_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "0110000000000000" report "FAILED: First term (in1): 10000000, second term (in2): 01000000, third term (in3): 1000000000000000, expected result: 0110000000000000, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '1' report "FAILED: First term (in1): 10000000, second term (in2): 01000000, third term (in3): 1000000000000000, expected result: '1', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: First term (in1): 10000000, second term (in2): 01000000, third term (in3): 1000000000000000, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Load acc = -28087.
	-- Reset a and b.
	-- Expected result: acc = -28087, no underflow, no overflow.
	in1_t <= "10000000";
	in2_t <= "01000000";
	in3_t <= "1001001001001001";
	sel_t <= '1';
	s_t <= '0';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "1001001001001001" report "FAILED: First term (in1): 10000000, second term (in2): 01000000, third term (in3): 1001001001001001, expected result: 1001001001001001, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '0' report "FAILED: First term (in1): 10000000, second term (in2): 01000000, third term (in3): 1001001001001001, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: First term (in1): 10000000, second term (in2): 01000000, third term (in3): 1001001001001001, expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	-- Load a = -96, b = -2.
	-- Keep acc.
	-- Expected result: acc = -27895, no underflow, no overflow.
	in1_t <= "10100000";
	in2_t <= "11111110";
	in3_t <= "1001000100100000";
	sel_t <= '0';
	s_t <= '1';
	r_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	sel_t <= '0';
	s_t <= '0';
    clk_t <= '0';
    wait for T/2;
	clk_t <= '1';
	wait for T/2;
	assert acc_t = "1001001100001001" report "FAILED: First term (in1): 10100000, second term (in2): 11111110, Sel (sel): '0', expected result: 1001001100001001, actual result (acc): " &
		INTEGER'IMAGE(to_integer(signed(acc_t)));
	assert underflow_t = '0' report "FAILED: First term (in1): 10100000, second term (in2): 11111110, Sel (sel): '0', expected result: '0', actual result (acc): " &
		std_logic'IMAGE(underflow_t);
	assert overflow_t = '0' report "FAILED: First term (in1): 10100000, second term (in2): 11111110, Sel (sel): '0', expected result: '0', actual result (acc): " &
		std_logic'IMAGE(overflow_t);
	wait for T/2;
	
	report "End test for MAC-unit.";
    wait;
  end process;
end test;