library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BaudRateGen is
 generic ( 
 N: integer := 5; -- amount of bits
 M: integer := 28 --mod 27 counter value
 );
 port(
    clk,reset: in std_logic;
    max_tick: out std_logic;
    q: out std_logic_vector(N-1 downto 0)
    );
 
end BaudRateGen;

architecture Behavioral of BaudRateGen is

signal r_reg: unsigned(N-1 downto 0);
signal r_next: unsigned(N-1 downto 0);
begin
    process(clk,reset)
     begin
     if (reset = '1') then
     r_reg <=(others => '0');
     elsif (clk'event and clk='1') then
     r_reg<=r_next;
     end if;
    end process;
    r_next<= (others => '0') when r_reg=(M-1) else
        r_reg+1;
    q<=std_logic_vector(r_reg);
    max_tick<='1' when r_reg=(M-1) else '0';
    
end Behavioral;
