LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY temp_score_gen IS
	PORT (
		clk_1hz, clk_25Mhz, enable : IN STD_LOGIC;
		score : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE behav OF temp_score_gen IS
BEGIN
	
	process (clk_1hz, enable, clk_25Mhz)
		variable v_score : UNSIGNED(7 DOWNTO 0);
		variable v_score_next : UNSIGNED(7 DOWNTO 0);
		variable prev_enable : STD_LOGIC := '0';
	begin
		if (rising_edge(clk_1hz)) then
			if (enable = '1' and prev_enable = '0') then
				v_score := (others => '0');
			end if;

			v_score_next := v_score;
			if (enable = '1' and v_score /= "11111111") then
				v_score_next := v_score + 1;
			end if;

			prev_enable := enable;
			v_score := v_score_next;
		end if;

		score <= STD_LOGIC_VECTOR(v_score);
	end process;
	
END behav;
