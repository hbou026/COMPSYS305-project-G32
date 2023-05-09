library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY life_point IS
  PORT (clk, touch_obstacle, touch_ground : IN STD_LOGIC;
        life_point : IN INTEGER;
        dead : OUT STD_LOGIC;
        life_point_left : OUT INTEGER);
END life_point;

ARCHITECTURE behav of life_point IS
  BEGIN
    
    PROCESS (clk, touch_obstacle, touch_ground, gmae_mode)
      VARIABLE current_life_point : INTEGER;
      
      BEGIN
        IF (touch_obstacle = '1' OR touch_ground = '1') THEN
          current_life_point := current_life_point - 1;
        END IF;
        
        IF (current_life_point = 0) THEN
          dead <= '1';
          