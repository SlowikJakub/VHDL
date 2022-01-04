
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TransmitterSubTB is
--  Port ( );
end TransmitterSubTB;

architecture Behavioral of TransmitterSubTB is
component transmitSub is
generic
(DBIT: integer := 8;
SB_TICK: integer := 16
);
port(
clk, reset: in std_logic;
tx_start: in std_logic;
s_tick: in std_logic;
din: inout std_logic_vector(7 downto 0);
tx_done_tick: out std_logic;
tx: out std_logic);
end component;

signal clk,reset,tx_start,s_tick,tx_done_tick,tx: std_logic;
signal din: std_logic_vector(7 downto 0);
constant clk_period : time := 20ns;
begin
tb: transmitSub port map( clk => clk,   
                             reset => reset,
                             tx_start => tx_start,
                             s_tick => s_tick,
                             din => din,
                             tx_done_tick => tx_done_tick,
                             tx => tx);
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
        din<="10101010";
        wait for 10ns;
end process;
process
    begin 
        s_tick <='1';
        wait for clk_period;
        s_tick <='0';
        wait for clk_period;
end process;
process
    begin 
        tx_start <='1';
        wait for clk_period;
        tx_start <='0';
        wait for clk_period;
end process;
end Behavioral;
