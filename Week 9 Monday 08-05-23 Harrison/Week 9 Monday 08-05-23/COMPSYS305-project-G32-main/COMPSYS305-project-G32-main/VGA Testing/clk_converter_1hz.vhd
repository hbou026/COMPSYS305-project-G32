library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- This component converts a 50MHz clk input to a 1Hz clock. 50Mhz = 10 wait between invert
-- (Assuming 50% duty cycle)
-- Written by Harrison Bound

entity clk_converter is
    port (clk_in : in std_logic;
     clk_out : out std_logic);
end entity clk_converter;

architecture behaviour of clk_converter is
signal v_clk_out : std_logic := '0';
signal clk_count : integer := 0;
begin
    process (clk_in)
        begin
            if (rising_edge(clk_in)) then
                clk_count <= clk_count + 1;

                -- if 0.5 seconds has elapsed invert clk_out signal. Assuming 50Mhz clk
                if (clk_count = 25000000) then
                    v_clk_out <= not v_clk_out;
                    clk_count <= 0;
                end if;
            end if;
        clk_out <= v_clk_out;
    end process;
end architecture behaviour;