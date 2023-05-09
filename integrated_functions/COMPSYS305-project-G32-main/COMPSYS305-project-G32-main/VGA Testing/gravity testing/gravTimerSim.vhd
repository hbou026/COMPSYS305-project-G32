LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
USE IEEE.NUMERIC_STD.ALL;


entity gravTimerSim is
port (clk, click : in std_logic;
      move_step : out std_logic_vector(9 downto 0));
end entity gravTimerSim;

architecture b1 of gravTimerSim is
signal gravity_timer : std_logic_vector(3 downto 0) := "0000";
signal move_step_int : integer range -512 to 511 := 0;

begin

process (clk, click)
begin
    if (rising_edge(clk)) then
        if (gravity_timer /= "0011") then 
            gravity_timer <= gravity_timer + "0001";
        else
            move_step_int <= move_step_int + 1;
            gravity_timer <= "0000";
        end if;
    end if;

    if (rising_edge(click)) then
        gravity_timer <= "0000";
        move_step_int <= -5;
    end if;
end process;


move_step <= std_logic_vector(to_signed(move_step_int, move_step'length));

end architecture b1;

