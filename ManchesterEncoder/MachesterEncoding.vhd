library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity ManchesterEncoding is
  Port ( 
  str_input:in std_logic_vector(7 downto 0);
  clk : in std_logic;
  reset : in std_logic;
  str_output:out std_logic);
end ManchesterEncoding;

architecture Behavioral of ManchesterEncoding is

type state_type is (idle,s0,s1,s2,s3,s4,s5,s6,s7);
signal state_reg, state_next : state_type;
signal str_buff, str_i: std_logic;

begin

    process(clk,reset)
        begin
         if(reset='1') then
             state_reg <= idle;
         elsif(rising_edge(clk)) then
            state_reg <= state_next;
         end if;
       end process;
     process(clk,reset)
     begin
        if(reset='1') then
            str_buff <='0';
         elsif(rising_edge(clk)) then
            str_buff <= str_i;
         end if;
       end process;
       
    process(state_reg)
     begin
     case state_reg is  
        when idle => 
            state_next<=s0;
        when s0 =>
            state_next<=s1;
        when s1 =>
            state_next<=s2;
        when s2 =>
            state_next<=s3;
        when s3 =>
            state_next<=s4;
        when s4 =>
            state_next<=s5;
        when s5 =>
            state_next<=s6;
        when s6 =>
            state_next<=s7;
        when s7 =>
            state_next<=idle;
     end case;
     end process;
     
    process(state_reg)
        begin
        case state_reg is
        when idle => 
            str_i<='0';
        when s0 =>
             str_i<=str_input(7);
        when s1 =>
             str_i<=str_input(6);
        when s2 =>
             str_i<=str_input(5);
        when s3 =>
            str_i<=str_input(4);
        when s4 =>
             str_i<=str_input(3);
        when s5 =>
             str_i<=str_input(2);
        when s6 =>
             str_i<=str_input(1);
        when s7 =>
             str_i<=str_input(0);
     end case;
     end process;

str_output<= not ( str_i xor clk);
         
end Behavioral;
