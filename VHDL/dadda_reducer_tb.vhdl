library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the Dadda-reducer.
entity dadda_reducer_tb is
end dadda_reducer_tb;

architecture test of dadda_reducer_tb is
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

  constant T : time := 20 ns;
  signal in1, in2 : std_logic_vector(7 downto 0);
  signal in3, out1, out2 : std_logic_vector(15 downto 0);
begin
  dadda_reducer_test : dadda_reducer port map(in1, in2, in3, out1, out2);

  process begin
    report "Start -> Test Dadda-reducer.";
  
    -- Tests selected input configurations.
    -- Due to the number of different input configurations and the already performed extensive tests
    -- of the used components, only a reduced subset of all input configurations are tested.
    for i in integer range -2**7 to 2**7-1 loop
	  if (i mod 16 = 0) then
	    report INTEGER'IMAGE(i+integer(128)) & "/256 tested.";
	  end if;
	  
	  if (i = integer(127)) then
	    report "256/256 tested.";
	  end if;
	
	  for j in integer range -2**7 to 2**7-1 loop
	    -- Very low accumulator values.
	    for k in integer range -2**15 to -2**15+10 loop
		  in1 <= std_logic_vector(to_signed(i, 8));
		  in2 <= std_logic_vector(to_signed(j, 8));
		  in3 <= std_logic_vector(to_signed(k, 16));
		  wait for T/2;
		  assert(std_logic_vector(signed(out1) + signed(out2)) = std_logic_vector(signed(in1)*signed(in2)+signed(in3))) report "FAILED: Reduction result incorrect with Input " &
		    INTEGER'IMAGE(i) & ", " & INTEGER'IMAGE(j) & ", " & INTEGER'IMAGE(k) severity error;
		  wait for T/2;
	    end loop;
		
		-- Medium low accumulator values.
	    for k in integer range -2**9 to -2**9+10 loop
		  in1 <= std_logic_vector(to_signed(i, 8));
		  in2 <= std_logic_vector(to_signed(j, 8));
		  in3 <= std_logic_vector(to_signed(k, 16));
		  wait for T/2;
		  assert(std_logic_vector(signed(out1) + signed(out2)) = std_logic_vector(signed(in1)*signed(in2)+signed(in3))) report "FAILED: Reduction result incorrect with Input " &
		    INTEGER'IMAGE(i) & ", " & INTEGER'IMAGE(j) & ", " & INTEGER'IMAGE(k) severity error;
		  wait for T/2;
	    end loop;
		
		-- Accumulator values around 0.
		for k in integer range -5 to 5 loop
		  in1 <= std_logic_vector(to_signed(i, 8));
		  in2 <= std_logic_vector(to_signed(j, 8));
		  in3 <= std_logic_vector(to_signed(k, 16));
		  wait for T/2;
		  assert(std_logic_vector(signed(out1) + signed(out2)) = std_logic_vector(signed(in1)*signed(in2)+signed(in3))) report "FAILED: Reduction result incorrect with Input " &
		    INTEGER'IMAGE(i) & ", " & INTEGER'IMAGE(j) & ", " & INTEGER'IMAGE(k) severity error;
		  wait for T/2;
	    end loop;
		
		-- Medium heigh accumulator values.
		for k in integer range 2**9-10 to 2**9 loop
		  in1 <= std_logic_vector(to_signed(i, 8));
		  in2 <= std_logic_vector(to_signed(j, 8));
		  in3 <= std_logic_vector(to_signed(k, 16));
		  wait for T/2;
		  assert(std_logic_vector(signed(out1) + signed(out2)) = std_logic_vector(signed(in1)*signed(in2)+signed(in3))) report "FAILED: Reduction result incorrect with Input " &
		    INTEGER'IMAGE(i) & ", " & INTEGER'IMAGE(j) & ", " & INTEGER'IMAGE(k) severity error;
		  wait for T/2;
	    end loop;
		
		-- Very heigh accumulator values.
		for k in integer range 2**15-11 to 2**15-1 loop
		  in1 <= std_logic_vector(to_signed(i, 8));
		  in2 <= std_logic_vector(to_signed(j, 8));
		  in3 <= std_logic_vector(to_signed(k, 16));
		  wait for T/2;
		  assert(std_logic_vector(signed(out1) + signed(out2)) = std_logic_vector(signed(in1)*signed(in2)+signed(in3))) report "FAILED: Reduction result incorrect with Input " &
		    INTEGER'IMAGE(i) & ", " & INTEGER'IMAGE(j) & ", " & INTEGER'IMAGE(k) severity error;
		  wait for T/2;
	    end loop;
	  end loop;
    end loop;
  
    report "End -> Test Dadda-reducer.";
    wait;
  end process;
end test;