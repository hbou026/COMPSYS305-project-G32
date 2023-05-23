library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY text_pos_gen IS
    PORT
    (
        clk : IN STD_LOGIC;
        pixel_row, pixel_col : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		  life_point : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		  score : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        font_row, font_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        character_address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
    );
END text_pos_gen;

ARCHITECTURE behav OF text_pos_gen IS

SIGNAL f_row, f_col: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
SIGNAL cha_add: STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN

font_row <= f_row;
font_col <= f_col;
character_address <= cha_add;

	PROCESS(clk, pixel_row, pixel_col)

    VARIABLE count : INTEGER RANGE 0 TO 63:= 0;
    VARIABLE count_col : INTEGER RANGE 0 TO 640 := 0;
	 VARIABLE count_row : INTEGER RANGE 0 To 480 := 0;

    BEGIN
		IF (rising_edge(clk)) THEN

        count_col := CONV_INTEGER(pixel_col);
		  count_row := CONV_INTEGER(pixel_row);

        IF (pixel_row >= CONV_STD_LOGIC_VECTOR(0, 10) AND pixel_row <= CONV_STD_LOGIC_VECTOR(51, 10)) THEN
            f_row <= conv_std_logic_vector(conv_integer(pixel_row(3 DOWNTO 1)) + 5, 3);
        ELSE
            f_row <= "111";
        END IF;

        IF (pixel_col >= CONV_STD_LOGIC_VECTOR(16, 10) AND pixel_col <= CONV_STD_LOGIC_VECTOR(335, 10)) THEN
            f_col <= pixel_col(3 DOWNTO 1);
        ELSE
            f_col <= "000";
        END IF;
		  
		  CASE count_row IS
		  
			WHEN 0 TO 19 =>
				--display text "LIFE POINT x";
				CASE count_col IS
					WHEN 16 TO 31 => count := 12;
					WHEN 32 TO 47 => count := 9;
					WHEN 48 TO 63 => count := 6;
					WHEN 64 TO 79 => count := 5;
					WHEN 80 TO 95 => count := 32;
					WHEN 96 TO 111 => count := 16;
					WHEN 112 TO 127 => count := 15;
					WHEN 128 TO 143 => count := 9;
					WHEN 144 TO 175 => count := 14;
					WHEN 176 TO 191 => count := 20;
					WHEN 192 TO 207 => count := 32;
					WHEN 208 TO 223 => count := (CONV_INTEGER(life_point) + 48);
					WHEN OTHERS => count := 32;
				END CASE;
				
			WHEN 20 TO 35 =>
				--display text "GAME MODE [mode name]"
				CASE count_col IS
					WHEN 16 TO 31 => count := 7;     --G
					WHEN 32 TO 47 => count := 1;     --A
					WHEN 48 TO 63 => count := 13;    --M
					WHEN 64 TO 79 => count := 5;     --E
					WHEN 80 TO 95 => count := 32;    --(space)
					WHEN 96 TO 111 => count := 13;   --M
					WHEN 112 TO 127 => count := 15;  --O
					WHEN 128 TO 143 => count := 4;   --D
					WHEN 144 TO 175 => count := 5;   --E
					WHEN 176 TO 191 => count := 32;  --(space)
					WHEN 192 TO 207 => count := 27;  --[
					WHEN 208 TO 223 => 
						CASE mode IS
							WHEN "00" => count := 20;     --T
							WHEN "01" => count := 5;      --E
							WHEN "10" => count := 8;      --H
							WHEN "11" => count := 5;      --E
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN 224 TO 239 =>
						CASE mode IS
							WHEN "00" => count := 18;     --R
							WHEN "01" => count := 1;      --A
							WHEN "10" => count := 1;      --A
							WHEN "11" => count := 24;     --X
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN 240 TO 255 =>
						CASE mode IS
							WHEN "00" => count := 1;      --A
							WHEN "01" => count := 19;     --S
							WHEN "10" => count := 18;     --R
							WHEN "11" => count := 20;     --T
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN 256 TO 271 =>
						CASE mode IS
							WHEN "00" => count := 9;      --I
							WHEN "01" => count := 25;     --Y
							WHEN "10" => count := 4;      --D
							WHEN "11" => count := 18;     --R
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN 272 TO 287 =>
						CASE mode IS
							WHEN "00" => count := 14;     --N
							WHEN "01" => count := 29;     --]
							WHEN "10" => count := 29;     --]
							WHEN "11" => count := 5;      --E
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN 288 TO 303 =>
						CASE mode IS
							WHEN "00" => count := 29;     --]
							WHEN "11" => count := 13;     --M
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN 304 TO 319 =>
						CASE mode IS
							WHEN "11" => count := 5;      --E
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN 320 TO 335 => 
						CASE mode IS
							WHEN "11" => count := 29;  --]
							WHEN OTHERS => count := 32;
						END CASE;
					WHEN OTHERS => count := 32;
				END CASE;
			WHEN 36 TO 51 =>
				--display text "SCORE x";
				CASE count_col IS
					WHEN 16 TO 31 => count := 19;
					WHEN 32 TO 47 => count := 3;
					WHEN 48 TO 63 => count := 17;
					WHEN 64 TO 79 => count := 18;
					WHEN 80 TO 95 => count := 5;
					WHEN 96 TO 111 => count :=32;
					WHEN 112 TO 127 => count := ((CONV_INTEGER(score) / 10) + 48);
					WHEN 128 TO 143 => count := ((CONV_INTEGER(score) MOD 10) + 48);
					WHEN OTHERS => count := 32;
				END CASE;
				
			WHEN OTHERS => count := 32;
			
		END CASE;
		END IF;
		cha_add <= CONV_STD_LOGIC_VECTOR(count, 6);
	END PROCESS;
END behav;