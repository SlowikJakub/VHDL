------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FIFOTB is
--  Port ( );
end FIFOTB;

architecture Behavioral of FIFOTB is

component FIFOReg is
generic( WIDTH : natural := 8;
         ADDRW : natural := 5);
  Port ( clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         wr_en : in STD_LOGIC;
         rd_en : in STD_LOGIC;
         wr_data : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
         rd_data : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
         empty_flag : out STD_LOGIC;
         full_flag : out STD_LOGIC
         );
end component;
signal clk, reset, wr_enable, rd_enable,empty_flag, full_flag: std_logic;
signal wr_data, rd_data: std_logic_vector(7 downto 0);
constant clk_period: time := 10ns;
 
begin
uut: FIFOReg port map( clk => clk,
                       reset => reset,
                       wr_en =>wr_enable,
                       rd_en => rd_enable,
                       wr_data => wr_data,
                       rd_data => rd_data,
                       empty_flag=> empty_flag,
                       full_flag => full_flag);

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

process
    begin
        wr_enable<='1';
        wait for clk_period;
        wr_enable <='0';
        wait for clk_period;
end process;

process
    begin 
        rd_enable <='1';
        wait for clk_period*28*16;
        rd_enable <='0';
        wait for (clk_period*28*16);
end process;

process
    begin
        wr_data <="10101010";
        wait for clk_period;
end process;
end Behavioral;
