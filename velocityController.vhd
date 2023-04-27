-- This component calculates the velocity as it changes due to gravity
-- Only outputs the velocity, it does not modify the position itself
-- Written by Harrison Bound, hbou026, April 2023

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Inputs: clock, enable, reset (from mouse click) are std_logic
--	  time_BCD value is provided by a 2 digit BCD counter (can be made a 1 or 3 digit BCD if needed)
--	  (time_BCD could be built into the component but rn is taken externally)

-- Outputs: vel_out is the output velocity. Currently kinda hardware intensive due to it being an integer (32 bits) but we can fix that later

entity velocityController is
	port(clk, reset_click, enable: in std_logic;
	     time_BCD: in std_logic_vector(7 downto 0);
             vel_out: out integer);
end entity velocityController;

architecture behaviour of velocityController is
begin
	
	process (clk)
	-- Define values
	variable velocity : integer;
	-- acceleration constant. Currently a placeholder value of 15 (pixels?) before we decide on how fast it should speed up
	variable acceleration : std_logic_vector(3 downto 0) := "1111"; 

	-- initial velocity value. We assume positive points down, thus if we want to jump we want initial velocity to be negative. Also to be adjusted and optimised (int)
	variable v_init : integer := -6;

	begin
		-- Note that enable has priority over reset (since reset is triggered by mouse click)
		if (rising_edge(clk) and enable = '1') then
			-- check mouse click - IMPORTANT: use rising edge so you cant click and hold to infinitely go up, must spam click
			if (rising_edge(reset_click)) then
				velocity := v_init;
			else
				-- increment velocity according to v(t) = v_i + a*t
				velocity := v_init + (to_integer(unsigned(acceleration)) * to_integer(unsigned(time_BCD)));
			end if;
		end if;
		
		vel_out <= velocity;
	end process;
	
end architecture behaviour;