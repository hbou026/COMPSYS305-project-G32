-- code for testing mouse functionality on hardware
-- Harrison Bound, hbou026, April 29th 2023


library IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity test_mouse is
	port(CLOCK_50 : in std_logic;
	     LEDR : out std_logic_vector(9 downto 0));
end entity test_mouse;

architecture behaviour of test_mouse is


-- Import Mouse and Clock converter components
component mouse is
PORT( clock_25Mhz, reset 		: IN std_logic;
         mouse_data					: INOUT std_logic;
         mouse_clk 					: INOUT std_logic;
         left_button, right_button	: OUT std_logic;
		 mouse_cursor_row 			: OUT std_logic_vector(9 DOWNTO 0); 
		 mouse_cursor_column 		: OUT std_logic_vector(9 DOWNTO 0)); 
end component mouse;

component clk_25_converter is
port(clock_50 : in std_logic;
     clock_25 : out std_logic);
end component clk_25_converter;

--component mouse_led is
 --   Port ( clk : in  STD_LOGIC;
--           btn : in  STD_LOGIC;
--           led : out STD_LOGIC);
--end component mouse_led;


-- signals (some used, some not)
signal clk_25 : std_logic;
signal mouse_data : std_logic;
signal mouse_clk : std_logic;
signal reset : std_logic;
signal mouse_cursor_row : std_logic_vector(9 downto 0);
signal mouse_cursor_column : std_logic_vector(9 downto 0);
signal left_btn : std_logic;
signal right_btn : std_logic;

begin
	-- instantiate components
	clk_conv : clk_25_converter port map (clock_50 => CLOCK_50, clock_25 => clk_25);
	mouse_DUT : mouse port map (clk_25, reset, mouse_data, mouse_clk, left_btn, right_btn, mouse_cursor_row, mouse_cursor_column);
	--left_LED : mouse_led port map (clk_25, left_btn, LEDR(1));
	--right_LED : mouse_led port map (clk_25, right_btn, LEDR(0));
	
	LEDR(1) <= left_btn;
	LEDR(0) <= right_btn;
	
end architecture behaviour;