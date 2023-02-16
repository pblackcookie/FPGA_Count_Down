----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2023 09:38:46
-- Design Name: 
-- Module Name: btn_debounce - Behavioral
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

entity btn_debounce is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           btn_out : out STD_LOGIC);
end btn_debounce;

architecture Behavioral of btn_debounce is
SIGNAL tmp : INTEGER := 0;
begin
process(btn,clk)
  begin
      if rising_edge(clk) then --use btnC button as clk in this task  ck=>btnC
            if(btn = '1')then
                tmp <= tmp+1;
                if(tmp = 3000000) then--wait for 30ms in real
                    btn_out <= '1';--if btnC continue press in 20ms, it shows the button be pressed
                else
                    btn_out <= '0';--no button be pressed
                end if;
            else
                tmp <= 0; --reset the count to 0
            end if;
        end if;
	end process;


end Behavioral;
