library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity Pong_Game is
  generic (
    g_videoWidth : integer;
    g_totalCols  : integer;
    g_totalRows  : integer;
    g_activeCols : integer;
    g_activeRows : integer
  );
  port (
    i_Clk       : in std_logic;
    i_gameStart : in std_logic;
    i_P1Up      : in std_logic;
    i_P1Dn      : in std_logic;
    i_P2Up      : in std_logic;
    i_P2Dn      : in std_logic;
    i_colCount  : in std_logic_vector(9 downto 0);
    i_rowCount  : in std_logic_vector(9 downto 0);
    o_P1Score   : out std_logic_vector(3 downto 0);
    o_P2Score   : out std_logic_vector(3 downto 0);
    o_draw      : out std_logic
  ) ;
end Pong_Game;

architecture Behavior of Pong_Game is

  type t_SM_Main is (s_Idle, s_Running, s_P1_Wins, s_P2_Wins, s_Cleanup);
  signal r_SM:Main : t_SM_Main := s_Idle;

  signal w_colCount, w_rowCount : std_logic_vector(9 downto 0);

  signal w_colCountDiv, w_rowCountDiv : std_logic_vector(5 downto 0);

  signal w_colIndex : integer range 0 to 2**w_colCountDiv'length - 1 := 0;
  signal w_rowIndex : integer range 0 to 2**w_rowCountDiv'length - 1 := 0;

  signal, w_drawPaddleP1, w_drawPaddleP2, w_drawBall : std_logic;
  signal w_paddleYP1, w_paddleYP2 : std_logic_vector(5 downto 0);
  signal w_ballX, w_ballY : std_logic_vector(5 downto 0);

  signal w_gameActive : std_logic;

  signal w_paddleYP1Top, w_paddleYP1Bot : unsigned(5 downto 0);
  signal w_paddleYP2Top, w_paddleYP2Bot : unsigned(5 downto 0);

  signal r_P1Score, r_P2Score : integer range 0 to 9 := 0;
begin

  w_colCountDiv <= w_colCount(w_colcount'left downto 0);
  w_rowCountDiv <= w_rowCount(w_rowCount'left downto 0);
  
  paddleControlP1 : entity work.paddleControl
  generic (
    g_playerPaddleX => c_paddleColLocationP1
  )
  port (
    i_Clk         => i_Clk,
    i_colCountDiv => w_colCountDiv,
    i_rowCountdiv => w_rowCountDiv,
    i_paddleUp    => i_P1Up,
    i_paddleDn    => i_P1Dn,
    o_drawPaddle  => w_drawPaddleP1,
    o_paddleY     => w_paddleYP1
  );

  paddleControlP2 : entity work.paddleControl
  generic (
    g_playerPaddleX => c_paddleColLocationP2
  )
  port (
    i_Clk         => i_Clk,
    i_colCountDiv => w_colCountDiv,
    i_rowCountdiv => w_rowCountDiv,
    i_paddleUp    => i_P2Up,
    i_paddleDn    => i_P2Dn,
    o_drawPaddle  => w_drawPaddleP2,
    o_paddleY     => w_paddleYP2
  );


  end Behavior ; -- Behavior
