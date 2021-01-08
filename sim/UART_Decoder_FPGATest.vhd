library ieee;
use ieee.std_logic_1164.ALL;
-- use ieee.numeric_std.all;

entity UART_Decoder_FPGATest is
  port (
        i_Clk         : in std_logic;
        i_UART_RX : in std_logic;
        o_LED_1 : out std_logic;
        o_LED_2 : out std_logic;
        o_LED_3 : out std_logic
  ) ;
end UART_Decoder_FPGATest;

architecture Behavior of UART_Decoder_FPGATest is
    component UART_Decoder is
        port (
          i_clk : in std_logic;
          i_inputByte : in  std_logic_vector(7 downto 0);
          o_startGame : out std_logic;
          o_colorSel : out std_logic_vector(1 downto 0)
        ) ;
    end component;

    component UART_RX is
        generic (
          g_CLKS_PER_BIT : integer := 217
          );
        port (
          i_Clk       : in  std_logic;
          i_RX_Serial : in  std_logic;
          o_RX_DV     : out std_logic;
          o_RX_Byte   : out std_logic_vector(7 downto 0)
          );
      end component;

    signal w_byte : std_logic_vector(7 downto 0);
    signal w_colorSel : std_logic_vector(1 downto 0);

begin

    UARTDecoder : UART_Decoder
    port map (
        i_clk => i_clk,
        i_inputByte => w_byte,
        o_startGame => o_LED_1,
        o_colorSel => w_colorSel
    );

    o_LED_2 <= w_colorSel(1);
    o_LED_3 <= w_colorSel(0);

    UARTRx : UART_RX
    generic map (
        g_CLKS_PER_BIT => 217
    )
    port map (
        i_clk => i_clk,
        i_RX_Serial => i_UART_RX,
        o_RX_DV => open,
        o_RX_Byte => w_byte
    );

end Behavior ; -- Behavior