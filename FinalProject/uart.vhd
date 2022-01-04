library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity uart is
generic(
dbit : integer := 8
);
Port (
clk, reset, rx, tx_start: in std_logic;
txin : in std_logic_vector(7 downto 0);
rxout : out std_logic_vector(7 downto 0);
rx_done, tx_done, tx : out std_logic
 );
end uart;
architecture Behavioral of uart is
signal tick: std_logic;
component BaudRateGen is
 generic ( 
 N: integer := 5; -- amount of bits
 M: integer := 28 --mod 27 counter value
 );
 port(
    clk,reset: in std_logic;
    max_tick: out std_logic;
    q: out std_logic_vector(N-1 downto 0)
    );
end component;
component ReceivingSub is
generic(
DBIT : integer := 8;
SB_TICK : integer := 16
);
 Port (
 clk, reset, rx  : in std_logic;
 s_tick : in std_logic;
 rx_done_tick: out std_logic;
 dout: out std_logic_vector(7 downto 0)
  );
end component;
component transmitSub is
generic
(DBIT: integer := 8;
SB_TICK: integer := 16
);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           tx_start : in STD_LOGIC;
           s_tick : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (DBIT-1 downto 0);
           tx_done_tick: out STD_LOGIC;
           tx : out STD_LOGIC);     
end component;
begin
uut1: BaudRateGen port map( clk => clk, reset => reset, max_tick => tick, q => open );
uut2: ReceivingSub port map(clk => clk, reset => reset, rx=> rx, s_tick => tick, rx_done_tick=> rx_done, dout => rxout);
uut3: transmitSub port map (clk => clk, reset => reset, tx_start => tx_start, s_tick => tick, din => txin, tx_done_tick=> tx_done, tx=>tx);
end Behavioral;
