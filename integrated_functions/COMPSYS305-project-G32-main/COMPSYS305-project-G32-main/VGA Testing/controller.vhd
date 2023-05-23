library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY controller IS
	PORT ( clk, mode1, mode2, start, ball_on, pipe_on, text1_on, text2_on, dead : IN STD_LOGIC;
			 game_mode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			 red, green, blue, enable, detector_reset : OUT STD_LOGIC
			);
END controller;

ARCHITECTURE behav OF controller IS

SIGNAL status : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

BEGIN

	game_mode <= mode1 & mode2;
	
	STATUS_CONTROLLER : PROCESS(start, dead)
	BEGIN
		IF (start = '1') THEN
			status <= "01";
			detector_reset <= '0';
		ELSIF (dead = '1') THEN
			status <= "00";
			detector_reset <= '1';
		END IF;
	END PROCESS;
	
	WINDOW_CONTROLLER : PROCESS(clk, status, text1_on, text2_on, pipe_on, ball_on)
	BEGIN
		IF (rising_edge(clk)) THEN
			CASE status IS
				WHEN "00" =>
					enable <= '0';
					IF (text1_on = '1') THEN
						red <= text1_on;
						green <= text1_on;
						blue <= '0';
					ELSE
						red <= '0';
						green <= '0';
						blue <= '1';
					END IF;
				WHEN "01" =>
					enable <= '1';
					IF (text2_on = '1') THEN
						red <= '1';
						green <= '1';
						blue <= '0';
					ELSIF (ball_on = '1') THEN
						red <= '1';
						green <= '1';
						blue <= '0';
					ELSIF (pipe_on = '1') THEN
						red <= '0';
						green <= '1';
						blue <= '0';
					ELSE
						red <= '0';
						green <= '0';
						blue <= '1';
					END IF;
				WHEN OTHERS =>
					red <= text1_on;
					green <= text1_on;
					blue <= '0';
					enable <= '0';
			END CASE;
		END IF;
	END PROCESS;
END behav;	
					