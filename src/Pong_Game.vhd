library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pong_Game is
  generic (
      g_videoWidth : integer;
      g_totalCols : integer;
      g_totalRows : integer;
      g_activeCols : integer;
      g_activeRows : integer
  );
  port (
    i_Clk : in std_logic;
    i_gameStart : in std_logic;
    i_P1Up : in std_logic;
    i_P2Dn : in std_logic;
    i_P2Up : in std_logic;
    i_P2Dn : in std_logic;
    i_colCount : in std_logic_vector(9 downto 0);
    i_rowCount : in std_logic_vector(9 downto 0);
    o_draw : in std_logic
  ) ;
end Pong_Game;

architecture Behavior of Pong_Game is

    signal 

begin

end Behavior ; -- Behavior