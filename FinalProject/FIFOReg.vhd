library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFOReg is
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
end FIFOReg;

architecture Behavioral of FIFOReg is
    type register_file_type is array( 0 to 2**(ADDRW - 1)) of STD_LOGIC_VECTOR((WIDTH- 1) downto 0);
    signal register_file: register_file_type := (others => (others => '0'));
    signal currently_full, currently_empty : STD_LOGIC;
    signal r_ptr, w_ptr : UNSIGNED(ADDRW downto 0) := (others => '0');
begin
process(reset, clk)
    begin
        if (reset = '1') then
            r_ptr <= (others => '0');
            w_ptr <= (others => '0');
            register_file <= (others => (others => '0'));
        elsif (clk'event and clk = '1') then
            if (currently_full = '0' and wr_en = '1') then
                register_file(TO_INTEGER(w_ptr(ADDRW downto 0))) <= wr_data;
                w_ptr <= w_ptr + 1; -- Advance the write pointer
            end if;
            
            if (currently_empty = '0' and rd_en = '1') then
                r_ptr <= r_ptr + 1;
            end if;
        end if;
        
    end process;
rd_data <= register_file(TO_INTEGER(r_ptr((ADDRW - 1) downto 0)));
currently_full <= '1' when w_ptr = 2**(ADDRW) else '0';
full_flag <= currently_full; -- Map to external output signal
currently_empty <= '1' when (r_ptr = w_ptr) else '0';
empty_flag <= currently_empty; -- Map to external output signal

end Behavioral;