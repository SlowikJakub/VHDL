
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InterfaceTestBench is
--  Port ( );
end InterfaceTestBench;

architecture Behavioral of InterfaceTestBench is

component InterfaceCircuit
generic
(W: integer := 8);
port
(clk, reset: in std_logic;
clr_flag, set_flag: in std_logic; 
din: in std_logic_vector(W-1 downto 0); --from the reciever data out
dout: out std_logic_vector(W-1 downto 0); --data out
flag: out std_logic);
end component;


signal clk, reset,clr_flag,set_flag,flag :std_logic;
signal din,dout : std_logic_vector(7 downto 0);
 constant clk_period : time := 20ns;

begin
tb: InterfaceCircuit port map( clk => clk,
                             reset => reset,
                             clr_flag => clr_flag,
                             set_flag => set_flag,
                             din => din,
                             dout => dout,
                             flag => flag);
 process
    begin
        clk<='1';
        wait for clk_period;
        clk <='0';
        wait for clk_period;
end process;

process
    begin 
        reset <='1';
        wait for clk_period;
        reset <='0';
        wait for (clk_period *28*16);
end process;

process
    begin
        din <="10101010";
        wait for clk_period;
end process;
process
    begin
        set_flag <='1';
        wait for clk_period*28*16;
        set_flag <='0';
        wait for clk_period;
end process;
process
    begin
        clr_flag <='1';
        wait for clk_period;
        clr_flag <='0';
        wait for clk_period*28*16;
end process;

end Behavioral;
