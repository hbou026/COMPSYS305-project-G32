-- testbench file for 25Mhz clk converter simulation
-- Written by Harrison Bound, hbou026, April 29th 2023

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity test_clk_25 is
end entity test_clk_25;

architecture my_test of test_clk_25 is
    signal t_clk_in : std_logic;
    signal t_clk_out : std_logic;

    component clk_25_converter is
        port (clock_50 : in std_logic;
            clock_25 : out std_logic);
    end component;
begin
    DUT: clk_25_converter port map (t_clk_in, t_clk_out);
    -- clock generation
    clk_gen: process
    begin
        t_clk_in <= '0';
        wait for 10 ns;
        t_clk_in <= '1';
        wait for 10 ns;
    end process clk_gen;
end architecture my_test;