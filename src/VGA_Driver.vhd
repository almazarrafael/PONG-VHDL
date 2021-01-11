-- Purpose: Directly drives a 640x480 display using a 25MHz clock

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Driver is
  generic (
    g_totalCols  : integer;
    g_totalRows  : integer;
    g_activeCols : integer;
    g_activeRows : integer   
    );
  port (
    i_Clk       : in std_logic;
    i_red       : in std_logic_vector(2 downto 0);
    i_grn       : in std_logic_vector(2 downto 0);
    i_blu       : in std_logic_vector(2 downto 0);
    o_red       : out std_logic_vector(2 downto 0);
    o_grn       : out std_logic_vector(2 downto 0);
    o_blu       : out std_logic_vector(2 downto 0);
    o_HSync     : out std_logic;
    o_VSync     : out std_logic;
    o_colCount : out std_logic_vector(9 downto 0);
    o_rowCount : out std_logic_vector(9 downto 0)
    );
end entity VGA_Driver;

architecture RTL of VGA_Driver is

  signal r_colCount : integer range 0 to g_totalCols - 1 := 0;
  signal r_rowCount : integer range 0 to g_totalRows - 1 := 0;

  constant c_frontPorchHorz : integer := 18;
  constant c_backPorchHorz  : integer := 50;
  constant c_frontPorchVert : integer := 10;
  constant c_backPorchVert  : integer := 33;

begin

  p_Row_Col_Count : process (i_Clk) is
  begin
    if rising_edge(i_Clk) then
      if r_colCount = g_totalCols - 1 then
        if r_rowCount = g_totalRows - 1 then
          r_rowCount <= 0;
        else
          r_rowCount <= r_rowCount + 1;
        end if;
        r_colCount <= 0;
      else
        r_colCount <= r_colCount + 1;
      end if;
    end if;
  end process p_Row_Col_Count;

  -- Adds in Horizontal Front and Back Porch
  o_HSync <= '1' when (r_colCount < (c_frontPorchHorz + g_activeCols) or r_colCount > (g_totalCols - c_backPorchHorz - 1)) else '0';
  -- Adds in Vertical Front and Back Porch
  o_VSync <= '1' when (r_rowCount < (c_frontPorchVert + g_activeRows) or r_rowCount > (g_totalRows - c_backPorchVert - 1)) else '0';
    
  -- Only drives RGB signals during active time
  o_red <= i_red when (r_colCount < g_activeCols and r_rowCount < g_activeRows) else (others => '0');
  o_grn <= i_grn when (r_colCount < g_activeCols and r_rowCount < g_activeRows) else (others => '0');
  o_blu <= i_blu when (r_colCount < g_activeCols and r_rowCount < g_activeRows) else (others => '0');

  -- Used for finding current x, y for downstream modules
  o_colCount <= std_logic_vector(to_unsigned(r_colCount, o_colCount'length));
  o_rowCount <= std_logic_vector(to_unsigned(r_rowCount, o_rowCount'length));
  
end architecture RTL;
