----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: 
-- 
-- Create Date:    03/02/2021
-- Design Name:    Assignment1
-- Module Name:    main3_four_digits - Behavioral 
-- Description:    main file for final design
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main3_final is port (
   --sw : in UNSIGNED (15 downto 0);
   clk  : in  STD_LOGIC;
   btnU, btnD,  btnC  : in  STD_LOGIC;--btnL, btnR,
   seg  : out STD_LOGIC_VECTOR (6 downto 0);
   dp  : out STD_LOGIC;
   an   : out STD_LOGIC_VECTOR (3 downto 0));
end main3_final;

architecture Behavioral of main3_final is
signal clk_1s : STD_LOGIC :='0';
signal RESET: STD_LOGIC := '1'; --FSM
signal btn_out_U: STD_LOGIC; --button
signal btn_out_D: STD_LOGIC;
signal btn_out_C: STD_LOGIC;
-- Define the states and
-- Create a signal that uses the different states
type STATE is (STATE_SET, STATE_GO);
signal CUR_STATE, NX_STATE: STATE;
signal sw :UNSIGNED (15 downto 0) :="0000000000000000";     

begin
    four_digits_unit : entity work.four_digits(Behavioral)
        Port map (d3 => sw(15 downto 12),
                  d2 => sw(11 downto 8),
                  d1 => sw(7 downto 4),
                  d0 => sw(3 downto 0),
                  clk => clk, seg => seg, an => an, dp =>dp);
    clock_divider_1s : ENTITY work.Clock_Divider(Behavioral) GENERIC MAP(T_period => 50000000)
        Port map(clk_in => clk,
                 clk_out => clk_1s );
    btn_up: entity work.btn_debounce(Behavioral)
        port map( btn => btnU,
                  clk => clk,
                  btn_out => btn_out_U);
    btn_down: entity work.btn_debounce(Behavioral)
        port map( btn => btnD,
                  clk  => clk,
                  btn_out => btn_out_D);                                   
    btn_center: entity work.btn_debounce(Behavioral)
        port map( btn => btnC,
                  clk => clk,
                  btn_out => btn_out_C);
              
 
    state_registers : process (RESET, clk) --go into FSM
    begin
        if RESET = '1' then
            CUR_STATE <= STATE_GO;
            RESET <= not RESET; --control the FSM
        elsif rising_edge(clk) then
            CUR_STATE <= NX_STATE;
        end if;
    end process;
    
    state_transition : process (btn_out_U, btn_out_D, btn_out_C, clk_1s, CUR_STATE)
        variable minute: UNSIGNED(5 downto 0);
        variable second: UNSIGNED(5 downto 0);
        variable sw_min : UNSIGNED(5 downto 0);
        variable sw_sec : UNSIGNED(5 downto 0);
    begin
        case CUR_STATE is --includ all states "set and go"
            when STATE_SET =>
                if rising_edge(clk) then
                    if(btn_out_C = '1')then
                        NX_STATE <= STATE_GO;
                    else
                        NX_STATE <= STATE_SET;
                        if(btn_out_U = '1') then
                            second := "000000";
                            if minute = 60 then --60->0
                                minute := "000000";
                            else
                                minute := minute + 1;
                            end if;
                        end if;
                        if(btn_out_D = '1') then
                            if(second /= 0) then
                                second := "000000";
                            elsif(second = 0 and minute /= 0) then
                                minute := minute - 1;
                            elsif(second = 0 and minute = 0)then --0->60
                                minute := "111100";
                            end if;
                        end if;                        
                    end if;
                end if;
            when STATE_GO =>              
                if(btn_out_C = '1')then
                    NX_STATE <= STATE_SET;
                else
                    NX_STATE <= STATE_GO;
                    if rising_edge(clk_1s) then
                        if (second = 0 and minute /= 0) then
                            second := "111011"; --59
                            minute := minute - 1;
                        elsif(minute = 0 and second = 0)then --continue shows the 00:00
                                minute:="000000";
                                second:="000000";  
                        else
                            second := second - 1;
                        end if;
                    end if;
                end if;                     
        end case;
        
        if ( minute >="000000" and minute <="001001") then
                sw(15 downto 12) <= "0000";
                sw(11 downto 8) <= minute(3 downto 0); 
            elsif (  minute <= "010011") then --19
                sw(15 downto 12) <= "0001";
                sw_min := (minute - "001010");
                sw(11 downto 8) <= sw_min(3 downto 0); 
            elsif (  minute <= "011101") then  --29
                sw(15 downto 12) <= "0010";
                sw_min := (minute - "010100");
                sw(11 downto 8) <= sw_min(3 downto 0);    
            elsif (minute <= "100111") then --39
                sw(15 downto 12) <= "0011";
                sw_min := (minute - "011110");
                sw(11 downto 8) <= sw_min(3 downto 0);   
            elsif (minute <= "110001") then --49
                sw(15 downto 12) <= "0100";
                sw_min := (minute - "101000");
                sw(11 downto 8) <= sw_min(3 downto 0);  
            elsif (minute <= "111011") then --59
                sw(15 downto 12) <= "0101";
                sw_min := (minute - "110010");
                sw(11 downto 8) <= sw_min(3 downto 0);  
            elsif (minute <= "111100") then 
                sw(15 downto 12) <= "0110";
                sw(11 downto 8) <= "0000";
            end if;
            -- same logic as minute setting         
            if ( second >="000000" and second <="001001") then
                sw(7 downto 4) <= "0000";
                sw(3 downto 0) <= second(3 downto 0); 
            elsif (second <= "010011") then --19
                sw(7 downto 4) <= "0001";
                sw_sec := (second - "001010");
                sw(3 downto 0) <= sw_sec(3 downto 0); 
            elsif (second <= "011101") then  --29
                sw(7 downto 4) <= "0010";
                sw_sec := (second - "010100");
                sw(3 downto 0) <= sw_sec(3 downto 0);    
            elsif (second <= "100111") then --39
                sw(7 downto 4) <= "0011";
                sw_sec := (second - "011110");
                sw(3 downto 0) <= sw_sec(3 downto 0);   
            elsif (second <= "110001") then --49
                sw(7 downto 4) <= "0100";
                sw_sec := (second - "101000");
                sw(3 downto 0) <= sw_sec(3 downto 0);  
            elsif (second <= "111011") then --59
                sw(7 downto 4) <= "0101";
                sw_sec := (second - "110010");
                sw(3 downto 0) <= sw_sec(3 downto 0);  
            end if;        
    end process;       
end Behavioral;
