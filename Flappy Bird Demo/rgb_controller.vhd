library IEEE;
use  IEEE.STD_LOGIC_1164.all;

-- Takes the enable bits from player and pipes and outputs the rgb for the vsync

entity rgb_controller is
port ( player_on, pipe1_on, pipe2_on, clk : IN std_Logic;
		red, green, blue, death : OUT std_logic);
end entity rgb_controller;

architecture beh of rgb_controller is
begin

	process (clk)
	variable v_death : std_logic;
	begin
		if (rising_edge(clk)) then
			if (pipe1_on = '1') then -- green
				green <= '1';
				red <= '0';
				blue <= '0';
				
				if (player_on ='1') then
					v_death := '1';
					
				else 
					v_death := '0';
				end if;
				elsif (pipe2_on = '1') then -- green
				green <= '1';
				red <= '0';
				blue <= '0';
				
				if (player_on ='1') then
					v_death := '1';
					
				else 
					v_death := '0';
				end if;
			elsif (player_on = '1') then -- yellow
				red <= '1';
				green <= '1';
				blue <= '0';
			
			
			else -- aqua (bg)
				red <= '0';
				green <= '1';
				blue <= '1';
			end if;
				death <= v_death;
		end if;
	end process;

end architecture beh;