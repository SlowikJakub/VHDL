

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BRAM_512x8 is
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
end BRAM_512x8;

architecture Behavioral of BRAM_512x8 is
component RAMMemController is
generic( WIDTH: natural := 8;
         ADDRW: natural := 9);
 Port ( clk: in std_logic;
        reset: in std_logic;
        rd_data : in std_logic_vector(WIDTH-1 downto 0);
        ram_data_fRAM: in std_logic_vector(WIDTH-1 downto 0);
        rx_empty, tx_full: in std_logic;
        wr_en_ram, rd_en_FIFO: out std_logic;
        wr_en_FIFO: out std_logic;
        addr: out std_logic_vector(ADDRW-1 downto 0);
        d_out: out std_logic_vector(WIDTH-1 downto 0);
        d_in: out std_logic_vector(WIDTH-1 downto 0)      
 );
 end component;
 component RAM_infer is
 generic( WIDTH : natural := 8;
          ADDRW : natural := 9);
Port ( clk : in STD_LOGIC;
wr_en : in STD_LOGIC;
addr : in STD_LOGIC_VECTOR (ADDRW-1 downto 0);
d_in : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
d_out : out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
);
end component;


signal wr_ram: std_logic;
signal di_ram, do_ram: std_logic_vector((WIDTH-1) downto 0);
signal addr_ram: std_logic_vector((ADDRW-1) downto 0);

begin
RAMcontr: RAMMemController port map(
clk=> clk,
reset => reset,
rd_data => rx_data,
rx_empty => rx_empty,
wr_en_ram => wr_ram,
rd_en_FIFO => rx_rd,
addr=>addr_ram,
d_in=>di_ram,
tx_full=> tx_full,
wr_en_FIFO=> tx_wr,
ram_data_fRAM => do_ram,
d_out => tx_data);

RAM_512x8: RAM_Infer port map(
clk => clk,
wr_en => wr_ram,
addr => addr_ram,
d_in => di_ram,
d_out => tx_data);

end Behavioral;
