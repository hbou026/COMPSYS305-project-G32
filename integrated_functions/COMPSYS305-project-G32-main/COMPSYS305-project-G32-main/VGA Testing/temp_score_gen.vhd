LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;
USE IEEE.STD_LOGIC_ARITH.all;

ENTITY temp_score_gen IS
	PORT (
		score : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END ENTITY;

ARCHITECTURE behav OF temp_score_gen IS
BEGIN
	score <= "00111000";
END behav;