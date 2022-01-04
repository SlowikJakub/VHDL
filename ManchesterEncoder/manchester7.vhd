library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity manchester_encoder is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           en : in  STD_LOGIC;
           str_input : in  STD_LOGIC_VECTOR(7 downto 0);
           str_output : out  STD_LOGIC
          );
end manchester_encoder;

architecture Beh of manchester_encoder is

TYPE STATE_M IS (s0, s1, s2, s3, s4, s5, s6, s7);
SIGNAL state_mealy  : STATE_M;

TYPE STATE_ME IS (Y,Y1);
SIGNAL state_moore   : STATE_ME;

begin
    PROCESS (clk, en, reset)
    BEGIN
        if reset = '1' then
            state_mealy <= s0;
            state_moore <= Y;
            str_output <= '1';
        elsif clk'event and clk = '1' then
                if en = '0' then
                state_mealy <= s0;
                state_moore <= Y;
                str_output <= '1';
                else
                CASE state_mealy IS
                    WHEN s0 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(0);
                                state_moore <= Y1;
                                state_mealy <= s0;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(0));
                                state_moore <= Y;
                                state_mealy <= s1;
                        END CASE;
                        
                    WHEN s1 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(1);
                                state_moore <= Y1;
                                state_mealy <= s1;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(1));
                                state_moore <= Y;
                                state_mealy <= s2;
                        END CASE;

                    WHEN s2 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(2);
                                state_moore <= Y1;
                                state_mealy <= s2;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(2));
                                state_moore <= Y;
                                state_mealy <= s3;
                        END CASE;
                      
                    WHEN s3 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(3);
                                state_moore <= Y1;
                                state_mealy <= s3;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(3));
                                state_moore <= Y;
                                state_mealy <= s4;
                        END CASE;
                      
                    WHEN s4 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(4);
                                state_moore <= Y1;
                                state_mealy <= s4;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(4));
                                state_moore <= Y;
                                state_mealy <= s5;
                        END CASE;  
                    WHEN s5 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(5);
                                state_moore <= Y1;
                                state_mealy <= s5;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(5));
                                state_moore <= Y;
                                state_mealy <= s6;
                        END CASE; 
                                         
                    WHEN s6 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(6);
                                state_moore <= Y1;
                                state_mealy <= s6;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(6));
                                state_moore <= Y;
                                state_mealy <= s7;
                        END CASE;
                                        
                    WHEN s7 =>
                        CASE state_moore IS
                            WHEN Y =>
                                str_output <= str_input(7);
                                state_moore <= Y1;
                                state_mealy <= s7;
                            WHEN Y1 =>
                                str_output <= NOT(str_input(7));
                                state_moore <= Y;
                                state_mealy <= s0;
                        END CASE;
                      
                END CASE;
            end if;
        end if;
    END PROCESS;
end Beh;