library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SevenSegDecoder_FPGATest is
  port (
    i_clk         : in std_logic;
    i_switch_1    : in std_logic;
    o_Segment2_A  : out std_logic;
    o_Segment2_B  : out std_logic;
    o_Segment2_C  : out std_logic;
    o_Segment2_D  : out std_logic;
    o_Segment2_E  : out std_logic;
    o_Segment2_F  : out std_logic;
    o_Segment2_G  : out std_logic
  ) ;
end SevenSegDecoder_FPGATest;

architecture Behavior of SevenSegDecoder_FPGATest is
    component SevenSegDecoder is
        port (
          i_Clk        : in  std_logic;
          i_Binary_Num : in  std_logic_vector(3 downto 0);
          o_Segment_A  : out std_logic;
          o_Segment_B  : out std_logic;
          o_Segment_C  : out std_logic;
          o_Segment_D  : out std_logic;
          o_Segment_E  : out std_logic;
          o_Segment_F  : out std_logic;
          o_Segment_G  : out std_logic
          );
    end component SevenSegDecoder;

    signal r_number : std_logic_vector(3 downto 0);

begin

    SevenSegDecoderModule : SevenSegDecoder
    port map (
        i_clk => i_clk,
        i_Binary_Num => r_number,
        o_Segment_A => o_Segment2_A,
        o_Segment_B => o_Segment2_B,
        o_Segment_C => o_Segment2_C,
        o_Segment_D => o_Segment2_D,
        o_Segment_E => o_Segment2_E,
        o_Segment_F => o_Segment2_F,
        o_Segment_G => o_Segment2_G
    );

    clockProc : process (i_clk) is
    begin
        if (rising_edge(i_clk)) then
            if (i_switch_1 = '1') then
                r_number <= std_logic_vector(signed(r_number) + 1);
            end if;
        end if;
    end process clockProc;

end Behavior ; -- Behavior