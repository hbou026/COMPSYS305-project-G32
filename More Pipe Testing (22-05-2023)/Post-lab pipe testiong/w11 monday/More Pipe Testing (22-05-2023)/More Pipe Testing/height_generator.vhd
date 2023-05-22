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
variable v2_height : std_logic_vector(3 downto 0);
variable v1_height : std_logic_vector(3 downto 0);
begin
	if (rising_edge(clk)) then
		if (v1_height = "1111") then
			v2_height := "0000";
			
		elsif (tap = '1') then
			v2_height(0) := v1_height(1) xor tap;
			v2_height(1) := '1' xor v1_height(3);
			v2_height(2) := v1_height(2) xnor v1_height(3);
			v2_height(3) := v1_height(0) xor tap;
		else
			v2_height := v1_height + "0001";
		end if;
		height <= v2_height(3) & v2_height(0);
		v1_height := v2_height;
	end if;
	

end process;

end architecture behaviour;