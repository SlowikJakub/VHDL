library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;
entity JKFFTestBench is
--  Port ( );
end JKFFTestBench;
architecture Behavioral of JKFFTestBench is
component JKFlipFlop
port(
j: in STD_LOGIC;
k: in STD_LOGIC;
clk, reset: in STD_LOGIC;
en : in STD_LOGIC;
Q : out STD_LOGIC;
Qnot: out STD_LOGIC
);
end component;
signal j,k,clk,reset: std_logic :='0';
signal q, qnot, en: std_logic;
constant T: time:= 10ns;
begin
uut: JKFlipFlop port map(j=>j, k=>k,clk=>clk,reset=>reset, en=>en, Q=>q, Qnot=>qnot);
    process
        begin
        clk<='0';
        wait for T;
        clk<='1';
        wait for T;
        end process;
         
      process
        begin
        en<='1';
    reset <= '1';
            J<='1';
            K<='0';
      wait for T;
      
     reset <= '0';  
            J<='1';
            K<='0';
            wait for T;
        reset <= '1';
            J<='0';
            K<='1';
    wait for T; 
      
     reset <= '0';  
            J<='0';
            K<='1';
            wait for T; 
               
     reset <= '1';
            J<='1';
            K<='0';
    wait for T; 
      
     reset <= '0';  
            J<='1';
            K<='0';
            wait for T;
    reset <= '1';
            J<='1';
            K<='1';
    wait for T; 
      
     reset <= '0';  
            J<='1';
            K<='1';
            wait for T;
     
        end process;
end Behavioral;
