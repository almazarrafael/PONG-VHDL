library ieee;
use ieee.std_logic_1164.ALL;
-- use ieee.numeric_std.all;

entity UART_Decoder_tb is
end UART_Decoder_tb;

architecture Behavior of UART_Decoder_tb is

    component UART_Decoder is
        port (
          i_clk : in std_logic;
          i_inputByte : in  std_logic_vector(7 downto 0);
          o_startGame : out std_logic;
          o_colorSel : out std_logic_vector(1 downto 0)
        ) ;
    end component;

    signal i_clk_sig, o_startGame_sig : std_logic := '0';
    signal o_colorSel_sig : std_logic_vector(1 downto 0) := "00";
    signal i_inputByte_sig : std_logic_vector(7 downto 0) := (others => '0');

begin

    UUT : UART_Decoder
    port map (
        i_clk => i_clk_sig,
        i_inputByte => i_inputByte_sig,
        o_startGame => o_startGame_sig,
        o_colorSel => o_colorSel_sig
    );

    process is
    begin
        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"71"; -- Black
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"77"; -- Red
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"65"; -- Blue
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"72"; -- Green
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"74"; -- Start
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"74"; -- Start
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"74"; -- Start
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"74"; -- Start
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"74"; -- Start
        i_clk_sig <= '1';
        wait for 20 ns;

        i_clk_sig <= '0';
        wait for 20 ns;
        i_inputByte_sig <= x"74"; -- Start
        i_clk_sig <= '1';
        wait for 20 ns;
 
    end process;

end Behavior ; -- Behavior