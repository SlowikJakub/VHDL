--Baud Rate: 115200
--Sampling Rate of 115200* 16 = 1843200
--one clk cycle every 27.126 clk cycles of the system clock

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity BaudRateTestBench is
 generic ( 
 N: integer := 5
 );
--  Port ( );
end BaudRateTestBench;

architecture Behavioral of BaudRateTestBench is

 component BaudRateGen 
 port(
    clk,reset: in std_logic;
    max_tick: out std_logic;
    q: out std_logic_vector(N-1 downto 0)
    );
 end component;
 
 signal clk,reset,max_tick : std_logic;
 signal q : std_logic_vector (N-1 downto 0);
 constant clk_period: time := 10ns;
 
begin

tb: BaudRateGen port map ( clk => clk, 
                           reset => reset,
                           max_tick => max_tick, 
                           q=>q);

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
        wait for (clk_period*28*16);
       
end process;

end Behavioral;
