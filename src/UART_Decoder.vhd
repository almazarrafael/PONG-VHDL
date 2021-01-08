-- Purpose: takes UART keyboard input and outputs the appropriate signals for starting the game and selecting display color
-- colorSel[1:0]
-- Q- 00: White
-- W- 01: Red
-- E- 10: Blue
-- R- 11: Green
-- T- Start

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity UART_Decoder is
  port (
    i_clk : in std_logic;
    i_inputByte : in  std_logic_vector(7 downto 0);
    o_startGame : out std_logic;
    o_colorSel : out std_logic_vector(1 downto 0)
  ) ;
end UART_Decoder;

architecture Behavior of UART_Decoder is

    signal r_inputByte : std_logic_vector(7 downto 0) := (others => '0');
    signal r_startGame : std_logic := '0';
    signal r_colorSel : std_logic_vector(1 downto 0) := (others => '0'); -- default: 00 (Black)

begin

    clockProc : process (i_clk) is
    begin
        if (rising_edge(i_clk)) then
            r_inputByte <= i_inputByte;
            if (r_inputByte /= i_inputByte) then -- Previous input is not the same as current input
                case i_inputByte is
                    when x"71" => -- Q: White
                        r_colorSel <= "00";
                    when x"77" => -- W: Red
                        r_colorSel <= "01";
                    when x"65" => -- E: Blue
                        r_colorSel <= "10";
                    when x"72" => -- R: Green
                        r_colorSel <= "11";
                    when x"74" => -- T: Start game
                        r_startGame <= '1';
                    when others =>
                        r_startGame <= '0';
                end case;
            else -- Previous input is the same, set startGame back to 0
                r_startGame <= '0';
            end if;
        end if;
    end process clockProc;

    o_colorSel <= r_colorSel;
    o_startGame <= r_startGame;

end Behavior ; -- Behavior
