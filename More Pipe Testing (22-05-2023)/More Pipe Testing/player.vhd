LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY player IS
	PORT
		( pb1, pb2, clk, vert_sync	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue, player_on 			: OUT std_logic);		
END player;

architecture behavior of player is

SIGNAL ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);

signal gravity_timer : std_logic_vector(3 downto 0) := "0000";
signal move_step_int : integer range -10 to 10 := 0;



BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(310,11);

ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';

player_on <= ball_on;
-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <=  '1';
Green <= (not pb2) and (not ball_on);
Blue <=  not ball_on;


Move_Ball: process (clk, vert_sync, pb1)  	
begin


	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then			
		
		
		if (gravity_timer /= "0101") then 
            gravity_timer <= gravity_timer + "0001";
        else
            move_step_int <= move_step_int + 1;
            gravity_timer <= "0000";
      end if;
		
		if (pb1 = '1') then
        gravity_timer <= "0000";
        move_step_int <= -4;
    end if;
		
		-- Bounce off top of the screen, prevent from falling off
		if ( ('0' & ball_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) ) then
			ball_y_motion <= - CONV_STD_LOGIC_VECTOR(4,10);
			move_step_int <= -4;
		elsif (ball_y_pos <= size) then 
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
			move_step_int <= 2;
		else
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(move_step_int,10); -- set motion
		end if;
		
		
		-- Compute next ball Y position
		ball_y_pos <= ball_y_pos + ball_y_motion;
		
		--pb1_prev <= pb1
	end if;

end process Move_Ball;

END behavior;

