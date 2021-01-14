-- Purpose: Generate H-Sync and V-Sync signals for use with Go Board's 25 MHz clock and 640x480 display.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Sync_Pulses is
  generic (
      g_totalCols  : integer; -- 800
      g_totalRows  : integer; -- 525
      g_activeCols : integer; -- 640
      g_activeRows : integer  -- 480
  );
  port (
    i_clk      : in  std_logic;
    o_HSync    : out std_logic;
    o_VSync    : out std_logic;
    o_colCount : out std_logic_vector(9 downto 0);
    o_rowCount : out std_logic_vector(9 downto 0)
  ) ;
end entity VGA_Sync_Pulses;

architecture Behavior of VGA_Sync_Pulses is

    signal r_colCount : integer range 0 to (g_totalCols - 1)  := 0;
    signal r_rowCount : integer range 0 to (g_totalRows - 1) := 0;

begin

    clockProc : process (i_clk) is
    begin
        if (r_colCount = (g_totalCols - 1)) then
            r_colCount <= 0;
            if (r_rowCount = (g_totalRows - 1)) then
                r_rowCount <= 0;
            else
                r_rowCount <= r_rowCount + 1;
            end if;
        else
            r_colCount <= r_colCount + 1;
        end if;
    end process clockProc;

    o_HSync <= '1' when r_colCount < g_activeCols else '0';
    o_VSync <= '1' when r_rowCount < g_activeRows else '0';

    o_colCount <= std_logic_vector(to_signed(r_colCount, o_colCount'length));
    o_rowCount <= std_logic_vector(to_signed(r_rowCount, o_rowCount'length));

end architecture Behavior ;