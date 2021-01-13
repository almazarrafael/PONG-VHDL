-- Purpose: Additional logic for color select. Takes in color code and outputs corresponding RGB values

library ieee;
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;

entity colorMux is
  port (
    i_colorSel : in std_logic_vector(1 downto 0);
    i_draw     : in std_logic;
    o_red      : out std_logic_vector(2 downto 0);
    o_green    : out std_logic_vector(2 downto 0);
    o_blue     : out std_logic_vector(2 downto 0)
  ) ;
end entity colorMux;

architecture Behavior of colorMux is
    signal w_color : std_logic_vector(2 downto 0);
begin

    o_red   <= (others => w_color(2));
    o_green <= (others => w_color(1));
    o_blue  <= (others => w_color(0));

    w_color <= "111" when (i_colorSel = "00" and i_draw = '1') else -- White
             "100" when (i_colorSel = "01" and i_draw = '1') else -- Red
             "001" when (i_colorSel = "10" and i_draw = '1') else -- Blue
             "010" when (i_colorSel = "11" and i_draw = '1') else -- Green
             "000"; -- Black

end architecture Behavior ; -- Behavior