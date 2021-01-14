-- Purpose: Handles the player paddle control logic.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Pong_Pkg.all;

entity paddleControl is
  generic (
    g_playerPaddleX : integer
  );
  port (
    i_Clk         : in std_logic;
    i_colCountDiv : in std_logic_vector(5 downto 0);
    i_rowCountDiv : in std_logic_vector(5 downto 0);
    i_paddleUp    : in std_logic;
    i_paddleDn    : in std_logic;
    o_drawPaddle  : out std_logic;
    o_paddleY     : out std_logic_vector(5 downto 0)
  );
end entity paddleControl;

architecture Behavior of paddleControl is

    signal w_colIndex : integer range 0 to 2**i_colCountDiv'length := 0;
    signal w_rowIndex : integer range 0 to 2**i_rowCountDiv'length := 0;

    signal w_paddleCountEn : std_logic;

    signal r_paddleCount : integer range 0 to c_paddleSpeed := 0;
    
    signal r_paddleY : integer range 0 to c_gameHeight - c_paddleHeight - 1 := 0;

    signal r_drawPaddle : std_logic := '0';

begin

    w_colIndex <= to_integer(unsigned(i_colCountDiv));
    w_rowIndex <= to_integer(unsigned(i_rowCountDiv));

    w_paddleCountEn <= i_paddleUp xor i_paddleDn;

    p_movePaddles : process (i_Clk) is
    begin
        if (rising_edge(i_Clk)) then
            
            if (w_paddleCountEn = '1') then
                if r_paddleCount = c_paddleSpeed then
                    r_paddleCount <= 0;
                else
                    r_paddleCount <= r_paddleCount + 1;
                end if;
            else
                r_paddleCount <= 0;
            end if;
            
            if (i_paddleUp = '1' and r_paddleCount = c_paddleSpeed) then
                if (r_paddleY /= 0) then
                    r_paddleY <= r_paddleY - 1;
                end if;
            elsif (i_paddleDn = '1' and r_paddleCount = c_paddleSpeed) then
                if (r_paddleY /= c_gameHeight - c_paddleHeight - 1) then
                    r_paddleY <= r_paddleY + 1;
                end if;
            end if;
        end if;
    end process p_movePaddles;

    p_drawPaddles : process (i_Clk) is
    begin
        if (rising_edge(i_Clk)) then
            if (w_colIndex = g_playerPaddleX and w_rowIndex >= r_paddleY and w_rowIndex <= r_paddleY + c_paddleHeight) then
                r_drawPaddle <= '1';
            else
                r_drawPaddle <= '0';
            end if;
        end if;
    end process p_drawPaddles;

    o_drawPaddle <= r_drawPaddle;
    o_paddleY <= std_logic_vector(to_unsigned(r_paddleY, o_paddleY'length));

end architecture Behavior;