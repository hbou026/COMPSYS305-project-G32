-- 2 bit height generator
-- has taps based on inputs from the player

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
USE IEEE.numeric_std.all;

entity height_generator is 
port (clk, tap : IN std_logic;
		height : OUT std_logic_vector(1 downto 0));
end entity height_generator;

architecture behaviour of height_generator is
begin

process (clk)
variable v_height : std_logic_vector(3 downto 0);
begin
	if (rising_edge(clk)) then
		if (v_height = "1111") then
			v_height := "0000";
			
		elsif (tap = '1') then
			v_height(0) := v_height(1) xor tap;
			v_height(1) := not v_height(3);
			v_height(2) := v_height(2) xnor v_height(3);
			v_height(3) := v_height(0) and tap;
		else
			v_height := v_height + "0001";
		end if;
		height <= v_height(2) & v_height(0);
	end if;
	

end process;

end architecture behaviour;