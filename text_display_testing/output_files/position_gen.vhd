library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY position_gen IS
	PORT
	(
		clk : IN STD_LOGIC;
		font_row, font_col : INOUT STD_LOGIC_VECTOR(2 DOWNTO 0);
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
		if(f_row = "111") THEN
			f_row <= "000";
		ELSE
			f_row <= f_row + 1;
		END IF;
		
		if(f_col = "111") THEN
			f_col <= "000";
		ELSE
			f_col <= f_col + 1;
		END IF;
		
		cha_add <= CONV_STD_LOGIC_VECTOR(0, 6);
	END PROCESS;
END behav;