----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2023 09:14:03
-- Design Name: 
-- Module Name: Clock_Divider - Behavioral
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

entity Clock_Divider is
    GENERIC (T_period : NATURAL);
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end Clock_Divider;

architecture Behavioral of Clock_Divider is
signal cnt: INTEGER := 0;
signal result: STD_LOGIC := '0';

begin
process(clk_in)
    begin
        if RISING_EDGE(clk_in) then
            cnt <= cnt + 1;
            if (cnt = T_period) then -- period: T = 1s
                result <= not result;
                cnt <= 0 ; --reset
            end if;
        end if;  
end process;  
     clk_out <= result;
end Behavioral;
