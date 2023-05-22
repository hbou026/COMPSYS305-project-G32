LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY pipes IS
	PORT
		( enable, clk, vert_sync	: IN std_logic;
			-- speed : IN std_logic_vector(3 DOWNTO 0);
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		   green 			: OUT std_logic);		
END pipes;

architecture behavior of pipes is

SIGNAL pipes_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL pipes_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL pipes_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL pipes_x_motion			: std_logic_vector(9 DOWNTO 0); --:= "000000" & speed;




BEGIN           

size <= CONV_STD_LOGIC_VECTOR(14,10);
-- pipes_x_pos and pipes_y_pos show the (x,y) for the centre of pipes
pipes_x_pos <= CONV_STD_LOGIC_VECTOR(320,11);

pipes_on <= '1' when ( ('0' & pipes_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & pipes_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipes_y_pos <= pixel_row + size) and ('0' & pixel_row <= pipes_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Colours for pixel data on video signal
--Red <=  '0' when (enable = '1') else '1'; --pb1;
Green <= '1' when (enable = '1') else '1'; --(not pb2) and (not pipes_on);
--Blue <= '0' when (enable = '1') else '1'; -- not pipes_on;


Move_pipes: process (vert_sync)  	
begin
	-- Move pipes once every vertical sync
	if (rising_edge(vert_sync)) then			
		-- Bounce off top or bottom of the screen
		if ( ('0' & pipes_x_pos >= CONV_STD_LOGIC_VECTOR(639,10) - size) ) then
			pipes_x_motion <= - CONV_STD_LOGIC_VECTOR(1,10);
		elsif (pipes_x_pos <= size) then 
			pipes_x_motion <= CONV_STD_LOGIC_VECTOR(1,10);
		end if;
		-- Compute next pipes X position
		pipes_x_pos <= pipes_x_pos + pipes_x_motion;
	end if;
end process Move_pipes;





END behavior;

