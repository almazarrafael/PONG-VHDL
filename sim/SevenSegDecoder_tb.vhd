library ieee;
use ieee.std_logic_1164.all;

entity SevenSegDecoder_tb is
end SevenSegDecoder_tb;

architecture Behavior of SevenSegDecoder_tb is
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
      end component;

    signal i_Clk_sig, o_Segment_A_sig, o_Segment_B_sig, o_Segment_C_sig, o_Segment_D_sig, o_Segment_E_sig, o_Segment_F_sig, o_Segment_G_sig : std_logic := '0';
    signal i_Binary_Num_sig : std_logic_vector(3 downto 0) := "0000";
    signal o_total : std_logic_vector(7 downto 0) := "00000000";

begin
    UUT : SevenSegDecoder
    port map (
        i_Clk        => i_Clk_sig,
        i_Binary_Num => i_Binary_Num_sig,
        o_Segment_A  => o_Segment_A_sig,
        o_Segment_B  => o_Segment_B_sig,
        o_Segment_C  => o_Segment_C_sig,
        o_Segment_D  => o_Segment_D_sig,
        o_Segment_E  => o_Segment_E_sig,
        o_Segment_F  => o_Segment_F_sig,
        o_Segment_G  => o_Segment_G_sig
    );

    o_total <= '0' & o_Segment_A_sig & o_Segment_B_sig & o_Segment_C_sig & o_Segment_D_sig & o_Segment_E_sig & o_Segment_F_sig & o_Segment_G_sig;

    process is
    begin
        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"0";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"1";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"2";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"3";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"4";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"5";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"6";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"7";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"8";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"9";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"A";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"B";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"C";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"D";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"E";
        i_clk_sig <= '1';
        wait for 10 ns;

        i_clk_sig <= '0';
        wait for 10 ns;
        i_Binary_Num_sig <= X"F";
        i_clk_sig <= '1';
        wait for 10 ns;
    end process;

end Behavior ; -- Behavior