LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.numeric_std.all;

entity three_bit_to_integer is
port ( bit2, bit1, bit0 : IN std_logic;
		 int : OUT integer range 0 to 7);
end entity three_bit_to_integer;

architecture beh of three_bit_to_integer is
signal combined : std_logic_vector(2 downto 0);
begin
	combined <= bit2 & bit1 & bit0;
	int <= to_integer(unsigned(combined));

end architecture beh;