-- counts the number of clicks and can be sent to BCD to 7seg
-- Written by Harrison Bound, May 2023

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity click_counter is
port (clk, click, enable, reset : in std_logic;
		count : out std_logic_vector(3 downto 0));
end entity click_counter;

architecture behaviour of click_counter is
begin

	process (clk)
	variable v_count : integer range 0 to 9;
	variable prev_click : std_logic;
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				v_count := 0;
			elsif (enable = '1' and click = '1' and prev_click = '0') then -- rising edge click
				if (v_count = 9) then -- 9
					v_count := 0;
				else
					v_count := v_count + 1;
				end if;
			end if;
			count <= std_logic_vector(to_unsigned(v_count, count'length));
			prev_click := click;
		end if;
	end process;

end architecture behaviour;