library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY welcome_text IS
    PORT
    (
        clk : IN STD_LOGIC;
        pixel_row, pixel_col : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        font_row, font_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        character_address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
    );
END welcome_text;

ARCHITECTURE behav OF welcome_text IS

SIGNAL f_row, f_col: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
SIGNAL cha_add: STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN

font_row <= f_row;
font_col <= f_col;
character_address <= cha_add;

	PROCESS(clk, pixel_row, pixel_col)

    VARIABLE count : INTEGER := 0;
    VARIABLE count_col, count_row : INTEGER := 0;

    BEGIN

        count_col := CONV_INTEGER(pixel_col);
		  count_row := CONV_INTEGER(pixel_row);

        IF (pixel_row >= CONV_STD_LOGIC_VECTOR(100, 10) AND pixel_row <= CONV_STD_LOGIC_VECTOR(135, 10)) THEN
            f_row <= conv_std_logic_vector(conv_integer(pixel_row(3 DOWNTO 1)) + 6, 3);
        ELSE
            f_row <= "111";
        END IF;

        IF (pixel_col >= CONV_STD_LOGIC_VECTOR(160, 10) AND pixel_col <= CONV_STD_LOGIC_VECTOR(495, 10)) THEN
            f_col <= pixel_col(3 DOWNTO 1);
        ELSE
            f_col <= "000";
        END IF;
		  
		  CASE count_row IS
		  
			WHEN 100 TO 119 =>
				--display text "BOUNCY BALL!";
				CASE count_col IS
					WHEN 224 TO 239 => count := 2;
					WHEN 240 TO 255 => count := 15;
					WHEN 256 TO 271 => count := 21;
					WHEN 272 TO 287 => count := 14;
					WHEN 288 TO 303 => count := 3;
					WHEN 304 TO 319 => count := 25;
					WHEN 320 TO 335 => count := 32;
					WHEN 336 TO 351 => count := 2;
					WHEN 352 TO 367 => count := 1;
					WHEN 368 TO 383 => count := 12;
					WHEN 384 TO 399 => count := 12;
					WHEN 400 TO 415 => count := 33;
					WHEN OTHERS => count := 32;
				END CASE;
				
			WHEN 120 TO 135 =>
				--display text "PRESS BUTTON TO START";
				CASE count_col IS
					WHEN 160 TO 175 => count := 16; --P
					WHEN 176 TO 191 => count := 18; --R
					WHEN 192 TO 207 => count := 5;  --E
					WHEN 208 TO 223 => count := 19; --S
					WHEN 224 TO 239 => count := 19; --S
					WHEN 240 TO 255 => count := 32; --(space)
					WHEN 256 TO 271 => count := 2;  --B
					WHEN 272 TO 287 => count := 21; --U
					WHEN 288 TO 303 => count := 20; --T
					WHEN 304 TO 319 => count := 20; --T
					WHEN 320 TO 335 => count := 15; --O
					WHEN 336 TO 351 => count := 14; --N
					WHEN 352 TO 367 => count := 32; --(space)
					WHEN 368 TO 383 => count := 20; --T
					WHEN 384 TO 399 => count := 15; --O
					WHEN 400 TO 415 => count := 32; --(space)
					WHEN 416 TO 431 => count := 19; --S
					WHEN 432 TO 447 => count := 20; --T
					WHEN 448 TO 463 => count := 1;  --A
					WHEN 464 TO 479 => count := 18; --R
					WHEN 480 TO 495 => count := 20; --T
					WHEN OTHERS => count := 32;
				END CASE;
				
			WHEN OTHERS => count := 32;
			
		END CASE;
		cha_add <= CONV_STD_LOGIC_VECTOR(count, 6);
	END PROCESS;
END behav;