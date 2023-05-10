library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY rgb_process IS
	PORT
	(
	text_in, red_in, green_in, blue_in : IN STD_LOGIC;
	red_out, green_out, blue_out : OUT STD_LOGIC
	);
END rgb_process;

ARCHITECTURE behav OF rgb_process IS
BEGIN
	PROCESS(text_in, red_in, green_in, blue_in)
	BEGIN
		IF (text_in = '1') THEN
			red_out <= '1';
			green_out <= '1';
			blue_out <= '0';
		ELSE
			red_out <= red_in;
			green_out <= green_in;
			blue_out <= blue_in;
		END IF;
	END PROCESS;
END behav;