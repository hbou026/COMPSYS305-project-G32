library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY collision_detection IS
	PORT (
		pixel_col : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		reset, ball_on, pipe_on, clk : IN STD_LOGIC;
		game_mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		life_point : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		dead : OUT STD_LOGIC
		);
END collision_detection;

ARCHITECTURE behav OF collision_detection IS
SIGNAL t_life_point : INTEGER:= 6;
SIGNAL init, t_dead, touch : STD_LOGIC := '0';
BEGIN
	
	life_point <= CONV_STD_LOGIC_VECTOR(t_life_point, 3);
	dead <= t_dead;

	PROCESS(clk, game_mode, ball_on, pipe_on)
	BEGIN
		IF (rising_edge(clk)) THEN
		
			IF (reset = '1') THEN
				init <= '0';
			ELSIF (init = '0') THEN
				CASE game_mode IS
					WHEN "00" => t_life_point <= 6;
					WHEN "01" => t_life_point <= 6;
					WHEN "10" => t_life_point <= 3;
					WHEN OTHERS => t_life_point <= 1;
				END CASE;
				init <= '1';
			ELSE
				CASE t_life_point IS
					WHEN 0 => t_dead <= '1';
					WHEN OTHERS =>
						t_dead <= '0';
						IF ((ball_on ='1') AND (pipe_on = '1') AND (touch = '0')) THEN
							touch <= '1';
							t_life_point <= t_life_point - 1;
						ELSIF ((pipe_on = '1') AND (CONV_INTEGER(pixel_col) = 227)) THEN
							touch <= '0';
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
	
END behav;
						