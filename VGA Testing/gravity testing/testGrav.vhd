--Testbench for gravTimerSim
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
USE IEEE.NUMERIC_STD.ALL;

entity testGrav is
end entity testGrav;

architecture test of testGrav is
signal t_clk, t_mouseClick : std_logic;
signal t_move_step : std_logic_vector(9 downto 0);

component gravTimerSim is
port (clk, click : in std_logic;
      move_step : out std_logic_vector(9 downto 0));
end component gravTimerSim;

begin
	DUT : gravTimerSim port map (t_clk, t_mouseClick, t_move_step);

	-- clk generation - 60Hz
	clk_gen : process
	begin
		t_clk <= '1';
		wait for 16 ms;
		t_clk <= '0';
		wait for 16 ms;
	end process clk_gen;

	-- mouse generation
	mouse_gen : process
	begin
		t_mouseClick <= '0';
		wait for 150 ms;
		t_mouseClick <= '1';
		wait for 20 ms;
		t_mouseClick <= '0';
		wait;
	end process mouse_gen;

end architecture test;