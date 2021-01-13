library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Pong_Pkg is
    constant c_gameWidth : integer := 40;
    constant c_gameHeight : integer := 30;

    constant c_scoreLimit : integer := 9;

    constant c_paddleHeight : integer := 6;

    constant c_paddleSpeed : integer := 1250000;

    constant c_ballSpeed : integer := 1250000;

    constant c_paddleColLocationP1 : integer := 0;
    constant c_paddleColLocationP2 : integer := c_gameWidth - 1;

    component paddleControl is
        generic (
          g_playerPaddleX : integer
        );
        port (
          i_Clk         : in std_logic;
          i_colCountDiv : in std_logic_vector(5 downto 0);
          i_rowCountdiv : in std_logic_vector(5 downto 0);
          i_paddleUp    : in std_logic;
          i_paddleDn    : in std_logic;
          o_drawPaddle  : in std_logic;
          o_paddleY     : in std_logic_vector(5 downto 0)
        ) ;
    end component;

    component pongBallControl is
        port (
          i_Clk         : in std_logic;
          i_gameActive  : in std_logic;
          i_colCountDiv : in std_logic_vector(5 downto 0);
          i_rowCountDiv : in std_logic_vector(5 downto 0);
          o_drawBall    : in std_logic;
          o_ballX       : in std_logic_vector(5 downto 0);
          o_ballY       : in std_logic_vector(5 downto 0)
        ) ;
    end component;

end package Pong_Pkg;