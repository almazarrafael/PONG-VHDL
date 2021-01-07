library ieee;
use ieee.std_logic_1164.all;

entity DebounceFilter is
  port (
    i_clk             : in std_logic;
    i_buttonInput     : in std_logic;
    o_debouncedButton : out std_logic
  ) ;
end DebounceFilter;

architecture Behavior of DebounceFilter is

    signal r_buttonState : std_logic := '0';
    -- Go Board 25MHz clock, 10 ms debounce limit => 25,000,000 * (0.01s) = 250,000 clock cycles
    constant c_debounceLimit : natural := 250000;
    signal r_counter : natural range 0 to c_debounceLimit := 0;

begin

    clockProc : process (i_clk) is
    begin
        if (rising_edge(i_clk)) then
            -- Current button state does not match registered button state & debounce limit does not equal to counter
            -- Used /= instead of < for 2nd comparison because it uses less resources and works the same
            if (i_buttonInput /= r_buttonState and r_counter /= c_debounceLimit) then
                r_counter <= r_counter + 1;
            -- Debounce limit reached
            elsif (r_counter = c_debounceLimit) then
                r_counter <= 0;
                r_buttonState <= i_buttonInput;
            -- Button state and registered button state are the same => reset the counter
            else
                r_counter <= 0;
            end if;
        end if;
    end process clockProc;

    o_debouncedButton <= r_buttonState;

end Behavior ; -- Behavior