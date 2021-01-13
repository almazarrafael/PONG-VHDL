library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Pong_Pkg.all;

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
  signal r_SMMain : t_SM_Main := s_Idle;

  signal w_colCount, w_rowCount : std_logic_vector(9 downto 0);

  signal w_colCountDiv, w_rowCountDiv : std_logic_vector(5 downto 0);

  signal w_colIndex : integer range 0 to 2**w_colCountDiv'length - 1 := 0;
  signal w_rowIndex : integer range 0 to 2**w_rowCountDiv'length - 1 := 0;

  signal w_drawPaddleP1, w_drawPaddleP2, w_drawBall : std_logic;
  signal w_paddleYP1, w_paddleYP2 : std_logic_vector(5 downto 0);
  signal w_ballX, w_ballY : std_logic_vector(5 downto 0);

  signal w_gameActive : std_logic;

  signal w_paddleYP1Top, w_paddleYP1Bot : unsigned(5 downto 0);
  signal w_paddleYP2Top, w_paddleYP2Bot : unsigned(5 downto 0);

  signal r_P1Score, r_P2Score : integer range 0 to c_scoreLimit := 0; -- score limit: 9
begin

  w_colCountDiv <= w_colCount(w_colcount'left downto 4);
  w_rowCountDiv <= w_rowCount(w_rowCount'left downto 4);
  
  paddleControlP1 : entity work.paddleControl
  generic map (
    g_playerPaddleX => c_paddleColLocationP1
  )
  port map (
    i_Clk         => i_Clk,
    i_colCountDiv => w_colCountDiv,
    i_rowCountdiv => w_rowCountDiv,
    i_paddleUp    => i_P1Up,
    i_paddleDn    => i_P1Dn,
    o_drawPaddle  => w_drawPaddleP1,
    o_paddleY     => w_paddleYP1
  );

  paddleControlP2 : entity work.paddleControl
  generic map (
    g_playerPaddleX => c_paddleColLocationP2
  )
  port map (
    i_Clk         => i_Clk,
    i_colCountDiv => w_colCountDiv,
    i_rowCountdiv => w_rowCountDiv,
    i_paddleUp    => i_P2Up,
    i_paddleDn    => i_P2Dn,
    o_drawPaddle  => w_drawPaddleP2,
    o_paddleY     => w_paddleYP2
  );

  pongBall : entity work.pongBallControl
  port map (
    i_Clk => i_Clk,
    i_gameActive => w_gameActive,
    i_colCountDiv => w_colCountDiv,
    i_rowCountDiv => w_rowCountDiv,
    o_drawBall => w_drawBall,
    o_ballX => w_ballX,
    o_ballY => w_ballY
  );

  w_paddleYP1Bot <= unsigned(w_paddleYP1);
  w_paddleYP1Top <= w_paddleYP1Bot + to_unsigned(c_paddleHeight, w_paddleYP1Bot'length);

  w_paddleYP2Bot <= unsigned(w_paddleYP2);
  w_paddleYP2Top <= w_paddleYP2Bot + to_unsigned(c_paddleHeight, w_paddleYP2Bot'length);

  P_SMMain : process (i_Clk) is
  begin
    if (rising_edge(i_Clk)) then
      case r_SMMain is
        when s_Idle =>
          if(i_gameStart = '1') then
            r_SMMain <= s_Running;
          end if;

        when s_Running =>
          if (w_BallX = std_logic_vector(to_unsigned(0, w_BallX'length))) then
            if (unsigned(w_BallY) < w_paddleYP1Bot or unsigned(w_BallY) > w_paddleYP1Top) then
              r_SMMain <= s_P2_Wins;
            end if;

          elsif (w_BallX = std_logic_vector(to_unsigned(c_gameWidth - 1, w_BallX'length))) then
            if (unsigned(w_BallY) < w_paddleYP2Bot or unsigned(w_BallY) > w_paddleYP2Top) then
              r_SMMain <= s_P1_Wins;
            end if;
          end if;
            
        when s_P1_Wins =>
          if (r_P1Score = c_scoreLimit) then
            r_P1Score <= 0;
            -- r_P2Score <= 0; Test later
          else
            r_P1Score <= r_P1Score + 1;
          end if;
          r_SMMain <= s_Cleanup;

        when s_P2_Wins =>
          if (r_P2Score = c_scoreLimit) then
            -- r_P1Score <= 0; Test later
            r_P2Score <= 0;
          else
            r_P2Score <= r_P2Score + 1;
          end if;
          r_SMMain <= s_Cleanup;

        when s_Cleanup =>
          r_SMMain <= s_Idle;

        when others =>
          r_SMMain <= s_Idle;
      end case;
    end if;
  end process P_SMMain;

  w_gameActive <= '1' when r_SMMain = s_Running else '0';
  
  o_P1Score <= std_logic_vector(to_unsigned(r_P1Score, o_P1Score'length));
  o_P2Score <= std_logic_vector(to_unsigned(r_P2Score, o_P2Score'length));

  --o_draw <= w_drawPaddleP2; -- always 0
  --o_draw <= w_drawPaddleP1; -- always 1
  o_draw <= w_drawBall; -- always 0
  --o_draw <= w_drawPaddleP2 or w_drawPaddleP1 or w_drawBall;

  end Behavior ; -- Behavior