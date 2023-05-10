library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY position_gen IS
	PORT
	(
		clk : IN STD_LOGIC;
		pixel_row, pixel_col : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		font_row, font_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		character_address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END position_gen;

ARCHITECTURE behav OF position_gen IS

SIGNAL f_row, f_col: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
SIGNAL cha_add: STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN

font_row <= f_row;
font_col <= f_col;
character_address <= cha_add;

	PROCESS(clk)
	BEGIN
		IF (pixel_row <= CONV_STD_LOGIC_VECTOR(16, 10)) THEN
			f_row <= pixel_row(3 DOWNTO 1);
		ELSE
			f_row <= "000";
		END IF;
		
		IF (pixel_col <= CONV_STD_LOGIC_VECTOR(176, 10)) THEN
			f_col <= pixel_col(3 DOWNTO 1);
		ELSE
			f_col <= "000";
		END IF;
		
		cha_add <= CONV_STD_LOGIC_VECTOR(1, 6);
	END PROCESS;
END behav;