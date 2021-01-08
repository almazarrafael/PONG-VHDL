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

    signal r_colCount : natural range 0 to (g_totalCols - 1)  := 0;
    signal r_rowCount : natural range 0 to (g_totalRows - 1) := 0;

    signal r_VSync : std_logic := '0';
    signal r_HSync : std_logic := '0';
    signal w_frameStart : std_logic;

begin

    clockProc1 : process (i_clk) is
    begin
        if (rising_edge(i_clk)) then
            r_HSync <= i_HSync;
            r_VSync <= i_VSync;
        end if;
    end process clockProc1;

    clockProc2 : process (i_clk) is
    begin
        if (rising_edge(i_clk)) then
            if (w_frameStart = '1') then
                r_colCount <= 0;
                r_rowCount <= 0;
            else
                if (r_colCount = (g_totalCols - 1)) then
                    if (r_rowCount = (g_totalRows - 1)) then
                        r_rowCount <= 0;
                    else
                        r_rowCount <= r_rowCount + 1;
                    end if;
                    r_colCount <= 0;
                else
                    r_colCount <= r_colCount + 1;
                end if;
            end if;
        end if;
    end process clockProc2;

    w_frameStart <= '1' when (r_VSync = '0' and i_VSync = '1') else '0';

    o_HSync <= r_HSync;
    o_VSync <= r_VSync;
    o_colCount <= std_logic_vector(to_unsigned(r_colCount, o_colCount'length));
    o_rowCount <= std_logic_vector(to_unsigned(r_rowCount, o_rowCount'length));

end Behavior ; -- Behavior