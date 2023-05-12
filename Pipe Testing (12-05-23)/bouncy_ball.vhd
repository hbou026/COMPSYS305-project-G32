LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bouncy_ball IS
	PORT
		( pb1, pb2, clk, vert_sync	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
END bouncy_ball;

architecture behavior of bouncy_ball is

SIGNAL ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_x_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(26,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_y_pos <= CONV_STD_LOGIC_VECTOR(200,10);

--ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
		--			and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
	--		'0';
ball_on <= '1' when ( (CONV_STD_LOGIC_VECTOR(0,10) <= (ball_y_pos - size)) and (not (('0' & ball_y_pos <= pixel_row + (size + size)) and ('0' & pixel_row <= ball_y_pos + (size + size))))-- and  (CONV_STD_LOGIC_VECTOR(479,10) >= ball_y_pos - size ) -- 0 < ball_y_pos
						and ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) ) else '0'; 	-- x_pos - size <= pixel_column <= x_pos + size
-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <=  '1' and (not ball_on);
Green <= (ball_on);
Blue <= '1' and (not ball_on);


Move_Ball: process (vert_sync)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then			
		-- Bounce off top or bottom of the screen
		if ( ('0' & ball_x_pos >= CONV_STD_LOGIC_VECTOR(639,11) - size) ) then
			ball_x_motion <= - CONV_STD_LOGIC_VECTOR(4,10);
		elsif (ball_x_pos <= size) then 
			--ball_x_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		end if;
		-- Compute next ball Y position
		if (ball_x_pos <= (size - 26)) then
			ball_x_pos <= ball_x_pos + CONV_STD_LOGIC_VECTOR(639,11);
		else
			ball_x_pos <= ball_x_pos + ball_x_motion;
		end if;
		
	end if;
end process Move_Ball;

END behavior;

