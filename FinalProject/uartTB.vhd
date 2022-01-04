library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uartTB is
--  Port ( );
end uartTB;

architecture Behavioral of uartTB is
component uart is
generic(
dbit : integer := 8
);
Port (
clk, reset, rx, tx_start: in std_logic;
txin : in std_logic_vector(7 downto 0);
rxout : out std_logic_vector(7 downto 0);
rx_done, tx_done, tx : out std_logic
 );
end component;

signal clk, reset, rx, tx_start, rx_done, tx_done, tx : std_logic;
signal txin, rxout : std_logic_vector(7 downto 0);
constant clk_period : time:= 20ns;

begin
tb: uart port map ( clk => clk, reset => reset, rx => rx, tx_start => tx_start, txin=> txin, rxout => rxout, rx_done => rx_done, tx_done => tx_done, tx => tx );
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
        wait for 1000ms;
end process;

process
    begin 
        rx <='1';
        wait for clk_period*28*16;
        rx <='0';
        wait for clk_period;
end process;

process
    begin 
        tx_start <='1';
        wait for clk_period*28*16;
        tx_start <='0';
        wait for clk_period;
end process;

process
    begin 
    
        txin <="01010101";
        wait for clk_period;

end process;

end Behavioral;
