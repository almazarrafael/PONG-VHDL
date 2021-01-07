library ieee;
use ieee.std_logic_1164.all;
 
entity SevenSegDecoder is
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
end entity SevenSegDecoder;

architecture Behavior of SevenSegDecoder is

    signal p_hexDecoder : std_logic_vector(7 downto 0) := (others => '0');

begin

    clockProc : process (i_Clk) is
    begin
        if (rising_edge(i_Clk)) then
            case i_Binary_Num is
                when "0000" => -- 0
                    p_hexDecoder <= X"7E";
                when "0001" => -- 1
                    p_hexDecoder <= X"30";
                when "0010" => -- 2
                    p_hexDecoder <= X"6D";
                when "0011" => -- 3
                    p_hexDecoder <= X"79";
                when "0100" => -- 4
                    p_hexDecoder <= X"33";
                when "0101" => -- 5
                    p_hexDecoder <= X"5B";
                when "0110" => -- 6
                    p_hexDecoder <= X"5F";
                when "0111" => -- 7
                    p_hexDecoder <= X"70";
                when "1000" => -- 8
                    p_hexDecoder <= X"7F";
                when "1001" => -- 9
                    p_hexDecoder <= X"7B";
                when "1010" => -- a
                    p_hexDecoder <= X"77";
                when "1011" => -- b
                    p_hexDecoder <= X"1F";
                when "1100" => -- c
                    p_hexDecoder <= X"4E";
                when "1101" => -- d
                    p_hexDecoder <= X"3D";
                when "1110" => -- e
                    p_hexDecoder <= X"4F";
                when "1111" => -- f
                    p_hexDecoder <= X"47";
                when others =>
                    p_hexDecoder <= X"00";
            end case;
        end if;
    end process clockProc;

    o_Segment_A <= p_hexDecoder(6);
    o_Segment_B <= p_hexDecoder(5);
    o_Segment_C <= p_hexDecoder(4);
    o_Segment_D <= p_hexDecoder(3);
    o_Segment_E <= p_hexDecoder(2);
    o_Segment_F <= p_hexDecoder(1);
    o_Segment_G <= p_hexDecoder(0);

end Behavior ; -- Behavior