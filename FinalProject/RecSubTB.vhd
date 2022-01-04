library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RecSubTB is
 -- Port ();
   generic( N: integer := 5);
end RecSubTB;

architecture Behavioral of RecSubTB is

component ReceivingSub
 Port (
 clk, reset, rx : in std_logic;
  s_tick : inout std_logic;
 rx_done_tick: inout std_logic;
 dout: out std_logic_vector(7 downto 0)
  );
  end component;


  signal clk, reset, rx, s_tick, rx_done_tick: std_logic;
  signal dout: std_logic_vector (7 downto 0);
  constant clk_period : time := 20ns;
begin

tb: ReceivingSub port map( clk=>clk, 
                           reset=>reset,
                           rx => rx,
                           s_tick => s_tick,
                           rx_done_tick => rx_done_tick,
                           dout=>dout);

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
        rx <='0';
        wait for clk_period;
        rx<='1';
        wait for (clk_period*28*16);

end process;

    process
    begin
        s_tick <='0';
        wait for clk_period;
        s_tick<='1';
        wait for clk_period;

end process;


end Behavioral;
