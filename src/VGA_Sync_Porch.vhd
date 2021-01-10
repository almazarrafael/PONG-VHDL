library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Sync_Porch is
  generic (
    g_videoWidth : integer;
    g_totalCols  : integer;
    g_totalRows  : integer;
    g_activeCols : integer;
    g_activeRows : integer  
  );
  port (
    i_clk        : in std_logic;
    i_HSync      : in std_logic;
    i_VSync      : in std_logic;
    i_redVideo   : in std_logic_vector((g_videoWidth - 1) downto 0);
    i_greenVideo : in std_logic_vector((g_videoWidth - 1) downto 0);
    i_blueVideo  : in std_logic_vector((g_videoWidth - 1) downto 0);
    o_HSync      : out std_logic;
    o_VSync      : out std_logic;
    o_redVideo   : out std_logic_vector((g_videoWidth - 1) downto 0);
    o_greenVideo : out std_logic_vector((g_videoWidth - 1) downto 0);
    o_blueVideo  : out std_logic_vector((g_videoWidth - 1) downto 0)
  ) ;
end entity VGA_Sync_Porch;

architecture Behavior of VGA_Sync_Porch is

    component Sync_To_Count is
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
    end component;

    constant c_frontPorchHoriz : integer := 18;
    constant c_backPorchHoriz  : integer := 50;
    constant c_frontPorchVert  : integer := 10;
    constant c_backPorchVert   : integer := 33;

    signal w_HSync, w_VSync : std_logic;
    signal r_HSync, r_VSync    : std_logic := '0';

    signal r_redVideo, r_greenVideo, r_blueVideo : std_logic_vector((g_videoWidth - 1) downto 0) := (others => '0');
    signal w_colCount, w_rowCount : std_logic_vector(9 downto 0);

begin

    syncToCount : Sync_To_Count
    generic map (
        g_totalCols => g_totalCols,
        g_totalRows => g_totalRows
    )
    port map (
        i_clk => i_clk,
        i_HSync => i_HSync,
        i_VSync => i_Vsync,
        o_HSync => w_HSync,
        o_VSync => w_VSync,
        o_colCount => w_colCount,
        o_rowCount => w_rowCount
    );

    clockProc1 : process (i_Clk) is
    begin
        if rising_edge(i_Clk) then
            if (to_integer(unsigned(w_colCount)) < c_frontPorchHoriz + g_activeCols or 
                to_integer(unsigned(w_colCount)) > g_totalCols - c_backPorchHoriz - 1) then
                r_HSync <= '1';
            else
                r_HSync <= w_HSync;
            end if;
        
            if (to_integer(unsigned(w_rowCount)) < c_frontPorchVert + g_activeRows or
                to_integer(unsigned(w_rowCount)) > g_totalRows - c_backPorchVert - 1) then
                r_Vsync <= '1';
            else
                r_VSync <= w_VSync;
            end if;
        end if;
    end process clockProc1;

    o_HSync <= r_HSync;
    o_VSync <= r_VSync;

    clockProc2 : process (i_clk) is
    begin
        if rising_edge(i_Clk) then
            r_redVideo <= i_redVideo;
            r_greenVideo <= i_greenVideo;
            r_blueVideo <= i_blueVideo;
      
            o_redVideo <= r_redVideo;
            o_greenVideo <= r_greenVideo;
            o_blueVideo <= r_blueVideo;
          end if;
    end process clockProc2;

end architecture Behavior ; -- Behavior