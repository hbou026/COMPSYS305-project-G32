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
            f_row <= conv_std_logic_vector(conv_integer(pixel_row(3 DOWNTO 1)) + 5, 3);
        ELSE
            f_row <= "111";
        END IF;

        IF (pixel_col >= CONV_STD_LOGIC_VECTOR(152, 10) AND pixel_col <= CONV_STD_LOGIC_VECTOR(503, 10)) THEN
            f_col <= pixel_col(3 DOWNTO 1);
        ELSE
            f_col <= "000";
        END IF;
		  
		  CASE count_row IS
		  
			WHEN 100 TO 119 =>
				--display text "BOUNCY BALL!";
				CASE count_col IS
					WHEN 216 TO 231 => count := 2;
					WHEN 232 TO 247 => count := 15;
					WHEN 248 TO 263 => count := 21;
					WHEN 264 TO 279 => count := 14;
					WHEN 280 TO 295 => count := 3;
					WHEN 296 TO 311 => count := 25;
					WHEN 312 TO 327 => count := 32;
					WHEN 328 TO 343 => count := 2;
					WHEN 344 TO 375 => count := 1;
					WHEN 376 TO 391 => count := 12;
					WHEN 392 TO 407 => count := 12;
					WHEN 408 TO 423 => count := 33;
					WHEN OTHERS => count := 32;
				END CASE;
				
			WHEN 120 TO 135 =>
				--display text "PRESS BUTTON TO START";
				CASE count_col IS
					WHEN 152 TO 167 => count := 16; --P
					WHEN 168 TO 183 => count := 18; --R
					WHEN 184 TO 199 => count := 5;  --E
					WHEN 200 TO 215 => count := 19; --S
					WHEN 216 TO 231 => count := 19; --S
					WHEN 232 TO 247 => count := 32; --(space)
					WHEN 248 TO 263 => count := 2;  --B
					WHEN 264 TO 279 => count := 21; --U
					WHEN 280 TO 295 => count := 20; --T
					WHEN 296 TO 311 => count := 20; --T
					WHEN 312 TO 327 => count := 15; --O
					WHEN 328 TO 343 => count := 14; --N
					WHEN 344 TO 375 => count := 32; --(space)
					WHEN 376 TO 391 => count := 20; --T
					WHEN 392 TO 407 => count := 15; --O
					WHEN 408 TO 423 => count := 32; --(space)
					WHEN 424 TO 439 => count := 19; --S
					WHEN 440 TO 455 => count := 20; --T
					WHEN 456 TO 471 => count := 1;  --A
					WHEN 472 TO 487 => count := 18; --R
					WHEN 488 TO 503 => count := 20; --T
					WHEN OTHERS => count := 32;
				END CASE;
				
			WHEN OTHERS => count := 32;
			
		END CASE;
		cha_add <= CONV_STD_LOGIC_VECTOR(count, 6);
	END PROCESS;
END behav;