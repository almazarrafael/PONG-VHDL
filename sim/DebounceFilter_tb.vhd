library ieee;
use ieee.std_logic_1164.all;

entity DebounceFilter_tb is
end DebounceFilter_tb;

architecture Behavior of DebounceFilter_tb is

    component DebounceFilter is
        port (
          i_clk             : in std_logic;
          i_buttonInput     : in std_logic;
          o_debouncedButton : out std_logic
        ) ;
    end component;

    signal i_clk_sig, i_buttonInput_sig, o_debouncedButton_sig : std_logic := '0';

begin

    UUT : DebounceFilter
    port map (
        i_clk             => i_clk_sig,
        i_buttonInput     => i_buttonInput_sig,
        o_debouncedButton => o_debouncedButton_sig
    );

    process is
    begin
        -- o_debouncedButton goes high after 10 ms (Debounce limit)
        i_clk_sig <= '0';
        wait for 20 ns;
        i_buttonInput_sig <= '1';
        i_clk_sig <= '1';
        wait for 20 ns;
    end process;

end Behavior ; -- Behavior