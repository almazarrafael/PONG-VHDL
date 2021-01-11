library ieee;
use ieee.std_logic_1164.all;

entity Pong_Top is
  port (
    i_Clk : in std_logic;
    i_UART_RX : in std_logic;
    i_Switch_1 : in std_logic;
    i_Switch_2 : in std_logic;
    i_Switch_3 : in std_logic;
    i_Switch_4 : in std_logic;
    o_VGA_HSync : out std_logic;
    o_VGA_HSync : out std_logic;
    o_VGA_Red_0 : out std_logic;
    o_VGA_Red_1 : out std_logic;
    o_VGA_Red_2 : out std_logic;
    o_VGA_Grn_0 : out std_logic;
    o_VGA_Grn_1 : out std_logic;
    o_VGA_Grn_2 : out std_logic;
    o_VGA_Blu_0 : out std_logic;
    o_VGA_Blu_1 : out std_logic;
    o_VGA_Blu_2 : out std_logic;
    o_Segment1_A : out std_logic;
    o_Segment1_B : out std_logic;
    o_Segment1_C : out std_logic;
    o_Segment1_D : out std_logic;
    o_Segment1_E : out std_logic;
    o_Segment1_F : out std_logic;
    o_Segment1_G : out std_logic;
    o_Segment2_A : out std_logic;
    o_Segment2_B : out std_logic;
    o_Segment2_C : out std_logic;
    o_Segment2_D : out std_logic;
    o_Segment2_E : out std_logic;
    o_Segment2_F : out std_logic;
    o_Segment2_G : out std_logic
  ) ;
end Pong_Top;

architecture Behavior of Pong_Top is

    constant c_videoWidth : integer := 3;
    constant c_totalCols  : integer := 800;
    constant c_totalRows  : integer := 525;
    constant c_activeCols : integer := 640;
    constant c_activeRows : integer := 480;

    signal w_RX_Byte : std_logic_vector(7 downto 0);
    signal w_colorSel : std_logic_vector(1 downto 0);
    signal w_startGame : std_logic;
    signal w_colCount, w_rowCount : std_logic_vector(9 downto 0);
    signal w_red, w_grn, w_blu : std_logic_vector(2 downto 0);
    signal w_Switch_1, w_Switch_2, w_Switch_3, w_Switch_4 : std_logic;
    signal w_draw : std_logic;
    signal w_P1Score, w_P2Score : std_logic_vector(3 downto 0);


begin

    -- UART Keyboard Input
    UART_Rx_Module : entity work.UART_RX
    generic map (
      g_CLKS_PER_BIT => 217)
    port map (
      i_Clk       => i_Clk,
      i_RX_Serial => i_UART_RX,
      o_RX_DV     => open,
      o_RX_Byte   => w_RX_Byte
    );

    -- UART Decoder to drive the right signals and hold its state
    UART_Decoder_Module : entity work.UART_Decoder
    port (
     i_clk => i_Clk,
     i_inputByte => w_RX_Byte,
     o_startGame => w_startGame,
     o_colorSel => w_colorSel
    );

    VGA_Driver_Module : entity work.VGA_Driver
    generic (
        g_totalCols  => c_totalCols,
        g_totalRows  => c_totalRows,
        g_activeCols => c_activeCols,
        g_activeRows => c_activeRows
    )
    port (
        i_Clk       => i_Clk,
        i_red       => open, -- Integrate
        i_grn       => open, -- Color MUX
        i_blu       => open, -- Later
        o_red       => w_red,
        o_grn       => w_grn,
        o_blu       => w_blu,
        o_HSync     => o_VGA_HSync,
        o_VSync     => o_VGA_VSync,
        o_colCount  => w_colCount,
        o_rowCount  => w_rowCount
    );

    debounceButton1 : entity work.DebounceFilter
    port (
        i_clk             => i_Clk,
        i_buttonInput     => i_Switch_1,
        o_debouncedButton => w_Switch_1
    );

    debounceButton2 : entity work.DebounceFilter
    port (
        i_clk             => i_Clk,
        i_buttonInput     => i_Switch_2,
        o_debouncedButton => w_Switch_2
    );

    debounceButton3 : entity work.DebounceFilter
    port (
        i_clk             => i_Clk,
        i_buttonInput     => i_Switch_3,
        o_debouncedButton => w_Switch_3
    );

    debounceButton4 : entity work.DebounceFilter
    port (
        i_clk             => i_Clk,
        i_buttonInput     => i_Switch_4,
        o_debouncedButton => w_Switch_4
    );

    Pong_Game_Module : entity work.Pong_Game
    generic (
        g_videoWidth => c_videoWidth,
        g_totalCols  => c_totalCols,
        g_totalRows  => c_totalRows,
        g_activeCols => c_activeCols,
        g_activeRows => c_activeRows
    )
    port (
        i_Clk       => i_Clk,
        i_gameStart => w_startGame,
        i_P1Up      => w_Switch_1,
        i_P2Dn      => w_Switch_2,
        i_P2Up      => w_Switch_3,
        i_P2Dn      => w_Switch_4,
        i_colCount  => w_colCount,
        i_rowCount  => w_rowCount,
        o_P1Score   => w_P1Score,
        o_P2Score   => w_P2Score,
        o_draw      => w_draw
    );

    -- Left digit, P1
    SevSeg1 : entity work.SevenSegDecoder
    port (
        i_Clk        : i_Clk,
        i_Binary_Num : w_P1Score,
        o_Segment_A  : o_Segment1_A,
        o_Segment_B  : o_Segment1_B,
        o_Segment_C  : o_Segment1_C,
        o_Segment_D  : o_Segment1_D,
        o_Segment_E  : o_Segment1_E,
        o_Segment_F  : o_Segment1_F,
        o_Segment_G  : o_Segment1_G
    );

    -- Right digit, P2
    SevSeg2 : entity work.SevenSegDecoder
    port (
        i_Clk        : i_Clk,
        i_Binary_Num : w_P2Score,
        o_Segment_A  : o_Segment2_A,
        o_Segment_B  : o_Segment2_B,
        o_Segment_C  : o_Segment2_C,
        o_Segment_D  : o_Segment2_D,
        o_Segment_E  : o_Segment2_E,
        o_Segment_F  : o_Segment2_F,
        o_Segment_G  : o_Segment2_G
    );

end Behavior ; -- Behavior
