----------------------------------------------------------------------------------
-- Company: Essex
-- Engineer: Yuxin Sun
-- 
-- Create Date: 13.02.2023 21:33:49
-- Design Name: 
-- Module Name: one_digit - Behavioral
-- Project Name:  main1_one_digit - Behavioral 
-- Target Devices: 
-- Tool Versions: 
-- Description:  1-digit 7-segment display decoder
-- 
-- Dependencies: one digit 
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main1_one_digit is
    Port (
        sw   : in  STD_LOGIC_VECTOR (15 downto 0);
        seg  : out STD_LOGIC_VECTOR (6 downto 0);
        dp   : out STD_LOGIC;
        an   : out STD_LOGIC_VECTOR (3 downto 0));
end main1_one_digit;

architecture Behavioral of main1_one_digit is

begin
    -- instantiate one one_digit decoder that will decode the active digit
    one_digit_unit : entity work.one_digit(Behavioral)
        Port map (digit => sw(3 downto 0), seg => seg);
    an <= sw(15 downto 12);
    dp <= sw(5);
       
end Behavioral;