library ieee;
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;

entity colorMux_tb is
end entity colorMux_tb;

architecture Behavior of colorMux_tb is

    component colorMux is
        port (
          i_colorSel : in std_logic_vector(1 downto 0);
          i_draw     : in std_logic;
          o_red      : out std_logic;
          o_green    : out std_logic;
          o_blue     : out std_logic
        ) ;
    end component;

    signal i_colorSel_sig : std_logic_vector(1 downto 0) := "00";
    signal i_draw_sig, o_red_sig, o_green_sig, o_blue_sig : std_logic := '0';

begin

    UUT : colorMux
    port map (
        i_colorSel => i_colorSel_sig,
        i_draw => i_draw_sig,
        o_red => o_red_sig,
        o_green => o_green_sig,
        o_blue => o_blue_sig
    );

    process is
    begin
        i_draw_sig <= '0';
        wait for 20 ns;
        i_colorSel_sig <= "00"; -- White
        wait for 20 ns;
        i_colorSel_sig <= "01"; -- Red
        wait for 20 ns;
        i_colorSel_sig <= "10"; -- Blue
        wait for 20 ns;
        i_colorSel_sig <= "11"; -- Green
        wait for 20 ns;
        i_draw_sig <= '1';
        wait for 20 ns;
        i_colorSel_sig <= "00"; -- White
        wait for 20 ns;
        i_colorSel_sig <= "01"; -- Red
        wait for 20 ns;
        i_colorSel_sig <= "10"; -- Blue
        wait for 20 ns;
        i_colorSel_sig <= "11"; -- Green
        wait for 20 ns;
    end process;


end architecture Behavior ; -- Behavior