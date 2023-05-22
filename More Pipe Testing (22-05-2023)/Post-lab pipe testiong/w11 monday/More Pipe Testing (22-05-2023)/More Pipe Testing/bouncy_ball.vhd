LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
USE IEEE.numeric_std.all;


ENTITY bouncy_ball IS
	PORT
		( pb1, pb2, clk, vert_sync	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
			 height : IN std_logic_vector(1 downto 0);
			 speed : IN integer range 0 to 7;
			 next_enable : IN std_logic;
			 next_x_pos : IN std_logic_vector(10 downto 0);
		  red, green, blue, next_pipe, pipe_on 			: OUT std_logic;
		  x_pos : OUT std_logic_vector(10 downto 0));		
END bouncy_ball;

architecture behavior of bouncy_ball is

SIGNAL ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_x_motion			: std_logic_vector(9 DOWNTO 0);
SIGNAL set_speed				: integer range 0 to 7;

BEGIN           



size <= CONV_STD_LOGIC_VECTOR(26,10);

ball_on <= '1' when ( (CONV_STD_LOGIC_VECTOR(0,10) <= (ball_y_pos - size)) and (not (('0' & ball_y_pos <= pixel_row + (size + size)) and ('0' & pixel_row <= ball_y_pos + (size + size))))-- and  (CONV_STD_LOGIC_VECTOR(479,10) >= ball_y_pos - size ) -- 0 < ball_y_pos
						and ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) and next_enable = '1') else '0'; 	-- x_pos - size <= pixel_column <= x_pos + size

pipe_on <= ball_on;
x_pos <= ball_x_pos;						
						
-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <=  (not next_enable) and (not ball_on);
Green <= (ball_on);
Blue <= (not next_enable) and (not ball_on);


Move_Ball: process (vert_sync, height)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync) and next_enable = '1') then			

	
	
		-- Compute next ball X position
		if (ball_x_pos <= (size - 26)) then
			ball_x_pos <= ball_x_pos + CONV_STD_LOGIC_VECTOR(639,11);
			
			-- Determine Height of the pipe based on 4 different inputs, change when it wraps back around
		case height is
    when "00" =>
      ball_y_pos <= CONV_STD_LOGIC_VECTOR(152, 10); -- low pipe
    when "01" =>
      ball_y_pos <= CONV_STD_LOGIC_VECTOR(310, 10); -- high pipe
    when "10" =>
      ball_y_pos <= CONV_STD_LOGIC_VECTOR(222, 10); -- middle pipe
    when others =>
      ball_y_pos <= CONV_STD_LOGIC_VECTOR(284, 10); -- low/middle pipe
  end case;
			
		else
			ball_x_pos <= ball_x_pos + ball_x_motion;
		end if;
		
		-- determine speed of pipe based on input
		ball_x_motion <= - CONV_STD_LOGIC_VECTOR(speed,10);
		
		-- Find x pos to START next pipe
	--	if (ball_x_pos <= CONV_STD_LOGIC_VECTOR(479, 10) and next_enable = '1') then
	--		next_pipe <= '1';
	--	end if;
		
	--	if (next_enable = '0') then
		--	next_pipe <= '0';
	--	end if;
		
	end if;
end process Move_Ball;
next_pipe <= '0' when (next_enable ='0') else '1' when (ball_x_pos <= CONV_STD_LOGIC_VECTOR(340, 10)) else '1' when (next_x_pos <= CONV_STD_LOGIC_VECTOR(479, 10)) else '0';
END behavior;

