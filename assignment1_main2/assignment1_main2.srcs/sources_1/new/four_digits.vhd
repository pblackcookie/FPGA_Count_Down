----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2023 23:09:07
-- Design Name: 
-- Module Name: four_digits - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity four_digits is
    Port ( d3 : in UNSIGNED (3 downto 0);
           d2 : in UNSIGNED (3 downto 0);
           d1 : in UNSIGNED (3 downto 0);
           d0 : in UNSIGNED (3 downto 0);
           ck : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           dp: out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0)
           );
end four_digits;

architecture Behavioral of four_digits is
    signal digit_present : UNSIGNED (3 downto 0); --show present digit
    signal count : UNSIGNED (1 downto 0); --  change the present digit (total four digits)
    SIGNAL tmp : INTEGER   := 0; -- count number for prevent change digit frequency too fast
    SIGNAL key_out   : STD_LOGIC; -- button state : 0 or 1
begin
    one_digit_unit : ENTITY work.one_digit(Behavioral)
        Port map (digit => digit_present(3 downto 0), 
                    seg => seg);

    process(ck)
    begin
        if rising_edge(ck) then
            count <= count +1;
        end if;
        case count is
            when "00" => 
                digit_present <= d0; dp <= '1'; an <= "1110"; 
            when "01" => 
                digit_present <= d1; dp <= '1'; an <= "1101"; 
            when "10" => 
                digit_present <= d2; dp <= '0'; an <= "1011";  -- show dp like the structure [minute.second]
            when others => 
                digit_present <= d3; dp <= '1'; an <= "0111"; 
        end case;
    end process;
    
  process(ck)
  begin
      if rising_edge(ck) then --use btnC button as clk in this task  ck=>btnC
            if(ck='0')then
                tmp<=tmp+1;
                if(tmp=2000000) then--wait for 20ms in real
                    key_out<='1';--if btnC continue press in 20ms, it shows the button be pressed
                else
                    key_out<='0';--no button be pressed
                end if;
            else
                tmp <= 0; --reset the count to 0
            end if;
        end if;
	end process;
    
    
    
end Behavioral;
