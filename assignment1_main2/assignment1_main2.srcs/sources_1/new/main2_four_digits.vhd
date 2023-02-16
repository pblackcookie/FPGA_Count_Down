----------------------------------------------------------------------------------
-- Company: Essex
-- Engineer: Yuxin Sun
-- 
-- Create Date: 13.02.2023 22:34:56
-- Design Name: Assignment1
-- Module Name: four_digits - Behavioral
-- Project Name: main2_four_digits 
-- Target Devices: 
-- Tool Versions: 
-- Description: main file for sub-design 2
--              implementing a 4-digit 7-segment display
--              decoder with manual time-multiplexing
-- 
-- Dependencies: four_digits(one_digit)
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity main2_four_digits is
    Port (
        sw   : in  UNSIGNED (15 downto 0);
        btnC : in  STD_LOGIC;
        --clk : in STD_LOGIC;
        seg  : out STD_LOGIC_VECTOR (6 downto 0);
        dp   : out STD_LOGIC;
        an   : out STD_LOGIC_VECTOR (3 downto 0));
end main2_four_digits;

architecture Behavioral of main2_four_digits is
begin
    -- instantiate one four_digits_unit decoder that will decode and
    -- and display one of the four digits
    four_digits_unit : entity work.four_digits(Behavioral)
        Port map (d3 => sw(15 downto 12),
                  d2 => sw(11 downto 8),
                  d1 => sw(7 downto 4),
                  d0 => sw(3 downto 0),
                  ck => btnC, seg => seg, an => an, dp => dp);

end Behavioral;
