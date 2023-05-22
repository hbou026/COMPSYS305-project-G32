
-- score counter

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
USE IEEE.numeric_std.all;

entity score_counter is
	port (  pipe1_x_pos, pipe2_x_pos : IN std_logic_vector(10 downto 0);
			  death, v_sync, reset : IN std_logic;
			  score : OUT std_logic_vector(9 downto 0));
end entity score_counter;

architecture behaviour of score_counter is
begin

	process (v_sync)
		variable v_score : std_logic_vector(9 downto 0);
		begin
			if (rising_edge(v_sync)) then
				if (reset = '1') then
					v_score := "0000000000";
				elsif (v_score /= "1111111111" and death = '0' and ((pipe1_x_pos <= CONV_STD_LOGIC_VECTOR(310,11)) or (pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(310,11)))) then
					v_score := v_score + "0000000001";
				
				end if;
			end if;
	end process;

end architecture behaviour;