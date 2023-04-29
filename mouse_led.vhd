-- Code to control leds for when mouse is clicked
-- Written by Harrison Bound with assistance from ChatGPT
-- April 29th, 2023

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mouse_led is
    Port ( clk : in  STD_LOGIC;
           btn : in  STD_LOGIC;
           led : out STD_LOGIC);
end entity mouse_led;

architecture Behavioral of mouse_led is
    type state_type is (IDLE, TOGGLE);
    signal state : state_type := IDLE;
    signal btn_prev : STD_LOGIC := '0';
    signal led_state : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when IDLE =>
                    if btn = '1' and btn_prev = '0' then
                        state <= TOGGLE;
                    end if;
                when TOGGLE =>
                    led_state <= not led_state;
                    state <= IDLE;
                when others =>
                    state <= IDLE;
            end case;
            led <= led_state;
            btn_prev <= btn;
        end if;
    end process;
end Behavioral;

