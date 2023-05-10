library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY text_pos_gen IS
	PORT
	(
		clk : IN STD_LOGIC;
		pixel_row, pixel_col : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		font_row, font_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		character_address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END text_pos_gen;

ARCHITECTURE behav OF text_pos_gen IS

SIGNAL f_row, f_col: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
SIGNAL cha_add: STD_LOGIC_VECTOR(5 DOWNTO 0);
TYPE sentence IS ARRAY(0 TO 11) OF INTEGER;
SIGNAL my_sentence : sentence := (2, 15, 21, 14, 3, 25, 32, 2, 1, 12, 12, 33);

BEGIN

font_row <= f_row;
font_col <= f_col;
character_address <= cha_add;

	PROCESS(clk, pixel_row, pixel_col)
	
	VARIABLE count : INTEGER := 0;
	
	BEGIN
		IF (pixel_row >= CONV_STD_LOGIC_VECTOR(0, 10) AND pixel_row <= CONV_STD_LOGIC_VECTOR(16, 10)) THEN
			f_row <= conv_std_logic_vector( conv_integer(pixel_row(3 DOWNTO 1)) + 5, 3);
		ELSE
			f_row <= "111";
		END IF;
		
		IF (pixel_col <= CONV_STD_LOGIC_VECTOR(192, 10)) THEN
			f_col <= pixel_col(3 DOWNTO 1);
		ELSE
			f_col <= "000";
		END IF;
		
		IF (count >= 11) THEN
			count := 0;
		ELSE
			count := count + 1;
		END IF;
		
		cha_add <= CONV_STD_LOGIC_VECTOR(count, 6);
	END PROCESS;
END behav;