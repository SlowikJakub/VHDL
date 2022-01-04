library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity JKFlipFlop is
Port (
j: in STD_LOGIC;
k: in STD_LOGIC;
clk, reset: in STD_LOGIC;
en : in STD_LOGIC;
Q : out STD_LOGIC;
Qnot: out STD_LOGIC
 );
end JKFlipFlop;

architecture Behavioral of JKFlipFlop is
signal q_reg,q_next : STD_LOGIC;

begin
    process(clk,reset)
        begin
        if(reset='1')then
                q_reg<='0';
        elsif(clk'event and clk='1')then
        q_reg <= q_next;
        end if;
        end process;
    q_next<= ((J AND (NOT q_reg)) OR ((NOT K) AND q_reg)) when en ='1'
    else q_reg;
    
    Q<=q_reg;
    Qnot<= NOT q_reg;
    
end Behavioral;