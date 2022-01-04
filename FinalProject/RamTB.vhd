library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity RamTB is
--  Port ( );
end RamTB;

architecture Behavioral of RamTB is
component BRAM_512x8 is
generic( WIDTH: natural := 8;
         ADDRW: natural := 9);
  Port ( clk : in std_logic;
         reset: in std_logic;
         rx_empty: in std_logic;
         tx_full: in std_logic;
         rx_data: in std_logic_vector((WIDTH-1) downto 0);
         tx_data: out std_logic_vector((WIDTH-1) downto 0);
         rx_rd: out std_logic;
         tx_wr: out std_logic);
end component;
signal clk, reset, rx_empty, tx_full, rx_rd, tx_wr: std_logic;
signal rx_data, tx_data: std_logic_vector(7 downto 0);


begin
tb: BRAM_512x8 port map( clk => clk,
                           reset => reset,
                           rx_data => rx_data,
                           rx_rd => rx_rd,
                           rx_empty => rx_empty,
                           tx_data => tx_data,
                           tx_wr => tx_wr,
                           tx_full => tx_full);

process
    begin 
        clk<='1';
        wait for 20ns;
        clk<='0';
        wait for 20ns;
end process;
process
    begin 
        reset<='1';
        wait for 20ns;
        reset<='0';
        wait for 20ns;
end process;

process
    begin 
        rx_empty<='1';
        tx_full<='1';
        wait for 20ns;
        rx_empty<='0';
        tx_full<='0';
        wait for 20ns;
end process;

process
    begin 
        rx_data<="00011111";
        wait for 20ns;
end process;
end Behavioral;
