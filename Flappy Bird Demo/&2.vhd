library IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity conc2 is
port (D1, D0 : IN std_logic;
		Q : OUT std_logic_vector(1 downto 0));
end entity conc2;

architecture b1 of conc2 is
begin
	Q <= D1 & D0;

end architecture b1;