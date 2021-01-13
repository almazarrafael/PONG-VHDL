library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Pong_Pkg.all;

entity pongBallControl is
  port (
    i_Clk         : in std_logic;
    i_gameActive  : in std_logic;
    i_colCountDiv : in std_logic_vector(5 downto 0);
    i_rowCountDiv : in std_logic_vector(5 downto 0);
    o_drawBall    : out std_logic;
    o_ballX       : out std_logic_vector(5 downto 0);
    o_ballY       : out std_logic_vector(5 downto 0)
  ) ;
end pongBallControl;

architecture Behavior of pongBallControl is

    signal w_colIndex : integer range 0 to 2**i_colCountDiv'length := 0;
    signal w_rowIndex : integer range 0 to 2**i_rowCountDiv'length := 0;
    
    signal r_ballCount : integer range 0 to c_ballSpeed := 0;

    signal r_ballX : integer range 0 to 2**i_colCountDiv'length := 0;
    signal r_ballY : integer range 0 to 2**i_rowCountDiv'length := 0;
    signal r_ballXPrev : integer range 0 to 2**i_colCountDiv'length := 0;
    signal r_ballYPrev : integer range 0 to 2**i_rowCountDiv'length := 0;

    signal r_drawBall : std_logic := '0';

begin

    w_colIndex <= to_integer(unsigned(i_colCountDiv));
    w_rowIndex <= to_integer(unsigned(i_rowCountDiv));

    p_moveBall : process (i_Clk) is
    begin
        if (rising_edge(i_Clk)) then
            if (i_gameActive = '0') then
                r_ballX <= c_gameWidth / 2;
                r_ballY <= c_gameHeight / 2;
                r_ballXPrev <= c_gameWidth / 2 + 1;
                r_ballYPrev <= c_gameHeight / 2 + 1;
            else
                -- Ball speed counter
                if r_ballCount = c_ballSpeed then
                    r_ballCount <= 0;
                else
                    r_ballCount <= r_ballCount + 1;
                end if;
                
                -- X pos
                if (r_ballCount = c_ballSpeed) then
                    r_ballXPrev <= r_ballX;

                    if (r_ballXPrev < r_ballX) then
                        if r_ballX = c_gameWidth - 1 then
                            r_ballX <= r_ballX - 1;
                        else
                            r_ballX <= r_ballX + 1;
                        end if;
                    elsif (r_ballXPrev > r_ballX) then
                        if (r_ballX = 0) then
                            r_ballX <= r_ballX + 1;
                        else
                            r_ballX <= r_ballX - 1;
                        end if;
                    end if;
                end if;

                -- Y pos
                if (r_ballCount = c_ballSpeed) then
                    r_ballYPrev <= r_ballY;

                    if (r_ballYPrev < r_ballY) then
                        if r_ballY = c_gameHeight - 1 then
                            r_ballY <= r_ballY - 1;
                        else
                            r_ballY <= r_ballY + 1;
                        end if;
                    elsif (r_ballYPrev > r_ballY) then
                        if (r_ballY = 0) then
                            r_ballY <= r_ballY + 1;
                        else
                            r_ballY <= r_ballY - 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process p_moveBall;

    p_drawBall : process (i_Clk) is
    begin
        if (rising_edge(i_Clk)) then
            if (w_colIndex = r_ballX and w_rowIndex = r_ballY) then
                r_drawBall <= '1';
            else
                r_drawBall <= '0';
            end if;
        end if;
    end process p_drawBall;

    o_drawBall <= r_drawBall;
    o_ballX <= std_logic_vector(to_unsigned(r_ballX, o_ballX'length));
    o_BallY <= std_logic_vector(to_unsigned(r_ballY, o_ballY'length));

end Behavior ; -- Behavior