library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench for the Brent-Kung-processor.
entity brent_kung_processor_tb is
end brent_kung_processor_tb;

architecture test of brent_kung_processor_tb is
  component brent_kung_processor is
    port(
	  g_1_in: in std_logic;
      p_1_in: in std_logic;
	  g_2_in: in std_logic;
	  p_2_in: in std_logic;
      g_out: out std_logic;
	  p_out: out std_logic
    );
  end component;

  constant T : time := 20 ns;
  signal g_1_in_t : std_logic;
  signal p_1_in_t : std_logic;
  signal g_2_in_t : std_logic;
  signal p_2_in_t : std_logic;
  signal g_out_t : std_logic;
  signal p_out_t : std_logic;
begin
  bkp : brent_kung_processor port map(g_1_in => g_1_in_t, p_1_in => p_1_in_t, g_2_in => g_2_in_t, p_2_in => p_2_in_t, g_out => g_out_t, p_out => p_out_t);
  
  -- Tests all input configurations.
  process begin
    report "Start -> Test Brent-Kung-processor.";
	
	for g1 in std_logic range '0' to '1' loop
	    g_1_in_t <= g1;
	    for p1 in std_logic range '0' to '1' loop
		    p_1_in_t <= p1;
		    for g2 in std_logic range '0' to '1' loop
			    g_2_in_t <= g2;
			    for p2 in std_logic range '0' to '1' loop
				    p_2_in_t <= p2;
					wait for T/2;
					assert g_out_t = ((p1 and g2) or g1) report "FAILED: First input (g_1_in): " & std_logic'IMAGE(g1) & 
					    ", second input (p_1_in): " & std_logic'IMAGE(p1) & "third input (g_2_in): " & std_logic'IMAGE(g2) &
						", fourth input (p_2_in): " & std_logic'IMAGE(p2) & ", expected result: " & std_logic'IMAGE(((p1 and g2) or g1)) &
			            ", actual result (g_out): " & std_logic'IMAGE(g_out_t);
					assert p_out_t = (p1 and p2) report "FAILED: First input (g_1_in): " & std_logic'IMAGE(g1) & 
					    ", second input (p_1_in): " & std_logic'IMAGE(p1) & "third input (g_2_in): " & std_logic'IMAGE(g2) &
						", fourth input (p_2_in): " & std_logic'IMAGE(p2) & ", expected result: " & std_logic'IMAGE(((p1 and p2))) &
			            ", actual result (g_out): " & std_logic'IMAGE(p_out_t);
					wait for T/2;
				end loop;
			end loop;
		end loop;
	end loop;
	
	report "End -> Test Brent-Kung-processor.";
    wait;
  end process;
  
end test;