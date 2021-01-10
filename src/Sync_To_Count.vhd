library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sync_To_Count is
  generic (
    g_totalCols  : integer; -- 800
    g_totalRows  : integer -- 525
  );
  port (
    i_clk : in std_logic;
    i_HSync : in std_logic;
    i_VSync : in std_logic;
    o_HSync : out std_logic;
    o_VSync : out std_logic;
    o_colCount : out std_logic_vector(9 downto 0);
    o_rowCount : out std_logic_vector(9 downto 0)
  ) ;
end Sync_To_Count;

architecture Behavior of Sync_To_Count is

    signal r_VSync : std_logic := '0';
    signal r_HSync : std_logic := '0';
    signal w_frameStart : std_logic;

    signal r_colCount : unsigned(9 downto 0) := (others => '0');
    signal r_rowCount : unsigned(9 downto 0) := (others => '0');

begin

    clockProc1 : process (i_clk) is
    begin
        if (rising_edge(i_clk)) then
            r_VSync <= i_VSync;
            r_HSync <= i_HSync;
        end if;
    end process clockProc1;

    clockProc2 : process (i_clk) is
    begin
        if (rising_edge(i_clk)) then
            if (w_frameStart = '1') then
                r_colCount <= (others => '0');
                r_rowCount <= (others => '0');
            else
                if (r_colCount = to_unsigned(g_totalCols - 1, r_colCount'length)) then
                    if (r_rowCount = to_unsigned(g_totalRows - 1, r_rowCount'length)) then
                        r_rowCount <= (others => '0');
                    else
                        r_rowCount <= r_rowCount + 1;
                    end if;
                    r_colCount <= (others => '0');
                else
                    r_colCount <= r_colCount + 1;
                end if;
            end if;
        end if;
    end process clockProc2;

    w_frameStart <= '1' when (r_VSync = '0' and i_VSync = '1') else '0';

    o_HSync <= r_HSync;
    o_VSync <= r_VSync;
    
    o_colCount <= std_logic_vector(r_colCount);
    o_rowCount <= std_logic_vector(r_rowCount);

end Behavior ; -- Behavior
