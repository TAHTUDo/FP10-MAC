library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the Brent-Kung-adder (8-Bit).
entity brent_kung_adder8_tb is
end brent_kung_adder8_tb;

architecture test of brent_kung_adder8_tb is
  component brent_kung_adder8 is
    port(
      in1: in std_logic_vector(7 downto 0);
	  in2: in std_logic_vector(7 downto 0);
	  out1: out std_logic_vector(7 downto 0)
    );
  end component;

  constant T : time := 20 ns;
  signal failures : integer := 0;
  signal in1_t : std_logic_vector(7 downto 0);
  signal in2_t : std_logic_vector(7 downto 0);
  signal out1_t : std_logic_vector(7 downto 0);
begin
  bka8 : brent_kung_adder8 port map(in1 => in1_t, in2 => in2_t, out1 => out1_t);
  
  -- Tests all input configurations.
  process begin
    report "Start -> Test Brent-Kung-adder 8-Bit.";
	
    for a in integer(-128) to integer(127) loop
	  in1_t <= std_logic_vector(to_signed(a, 8));
	  
	  for b in integer(-128) to integer(127) loop
	    in2_t <= std_logic_vector(to_signed(b, 8));
		wait for T/2;
		if not (signed(out1_t) = to_signed(a + b, 8)) then
		  failures <= failures + 1;
		end if;
		assert signed(out1_t) = to_signed(a + b, 8) report "FAILED: First term (in1): " &
		    INTEGER'IMAGE(a) & ", second term (in2): " & INTEGER'IMAGE(b) &
			", expected sum: " & INTEGER'IMAGE(to_integer(to_signed(a + b, 8))) & ", actual sum (out1): " &
			INTEGER'IMAGE(to_integer(signed(out1_t)));
	    wait for T/2;
	  end loop;
	  
	  if (a mod 64 = 0) then
	    report INTEGER'IMAGE(a+integer(128)) & "/256 tested. Total number of failures: " & INTEGER'IMAGE(failures);
	  end if;
	  if (a = integer(127)) then
	    report "256/256 tested. Total number of failures: " & INTEGER'IMAGE(failures);
	  end if;
    end loop;
	
	report "End -> Test Brent-Kung-adder 8-Bit.";
    wait;
  end process;
end test;