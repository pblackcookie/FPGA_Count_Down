----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.02.2023 00:07:18
-- Design Name: 
-- Module Name: bcdto7segment_dataflow - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity one_digit is
    Port (  digit : in STD_LOGIC_VECTOR (3 downto 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0));
end one_digit;

architecture Behavioral of one_digit is

begin
    WITH digit SELECT
       seg <= "1000000" WHEN "0000",
                        "1111001" WHEN "0001",
                        "0100100" WHEN "0010",
                        "0110000" WHEN "0011",
                        "0011001" WHEN "0100",
                        "0010010" WHEN "0101",
                        "0000010" WHEN "0110",
                        "1111000" WHEN "0111",
                        "0000000" WHEN "1000",
                        "0010000" WHEN "1001",
                        "1111111" WHEN OTHERS;


end Behavioral;
