LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity speed_calc is
    port (
        mode : in std_logic_vector(1 downto 0);
        speed : out integer range 0 to 7
    );
end entity speed_calc;

architecture beh of speed_calc is
begin
    process (mode)
    begin
        case mode is
            when "00" =>
                speed <= 2; -- training
            when "01" =>
                speed <= 3; -- easy
            when "10" =>
                speed <= 4; -- hard
            when "11" =>
                speed <= 6; -- extreme
            when others =>
                speed <= 2; -- default to training
        end case;
    end process;
end architecture beh;
