LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
USE IEEE.numeric_std.all;


-- Speed modifier for pipes based on levels and score

entity speed_mod is 
	port (gamemode : IN std_logic_vector(1 downto 0);
			score : IN std_logic_vector(7 downto 0);
			v_sync : IN std_logic;
			speed : OUT integer range 0 to 7);	
end entity speed_mod;

architecture behaviour of speed_mod is
begin

	process (v_sync, score)
	begin
		if (rising_edge(v_sync)) then
			case (gamemode) is
				when "00" => -- TRAIN, do not change speed
					speed <= 2;
				when "01" => -- EASY, increase in 10 to 15sec increments
					if (score <= CONV_STD_LOGIC_VECTOR(10, 8)) then
						speed <= 2;
					elsif (score <= CONV_STD_LOGIC_VECTOR(20, 8)) then
						speed <= 3;
					elsif (score <= CONV_STD_LOGIC_VECTOR(35, 8)) then
						speed <= 4;
					else
						speed <= 5;
					end if;
					
				when "10" => -- HARD, increase faster
					if (score <= CONV_STD_LOGIC_VECTOR(8, 8)) then
						speed <= 2;
					elsif (score <= CONV_STD_LOGIC_VECTOR(16, 8)) then
						speed <= 3;
					elsif (score <= CONV_STD_LOGIC_VECTOR(24, 8)) then
						speed <= 4;
					else
						speed <= 5;
					end if;
					
				when "11" => -- EXTREME
					if (score <= CONV_STD_LOGIC_VECTOR(5, 8)) then
						speed <= 2;
					elsif (score <= CONV_STD_LOGIC_VECTOR(13, 8)) then
						speed <= 3;
					elsif (score <= CONV_STD_LOGIC_VECTOR(18, 8)) then
						speed <= 4;
					elsif (score <= CONV_STD_LOGIC_VECTOR(30, 8)) then
						speed <= 5;
					else
						speed <= 6;
					end if;
				when others => speed <= 0;
			end case;			
		end if;
	end process;

end architecture behaviour;