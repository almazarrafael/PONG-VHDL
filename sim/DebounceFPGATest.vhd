library ieee;
use ieee.std_logic_1164.all;
 
entity DebounceFPGATest is
  port (
    i_Clk       : in  std_logic;
    i_Switch_1  : in  std_logic;
    o_LED_1     : out std_logic
    );
end DebounceFPGATest;
 
architecture Behavior of DebounceFPGATest is
 
    component DebounceFilter is
        port (
          i_clk             : in std_logic;
          i_buttonInput     : in std_logic;
          o_debouncedButton : out std_logic
        ) ;
    end component;

    signal r_LEDState : std_logic := '0';
    signal w_buttonState : std_logic;
    signal r_switch1 : std_logic := '0';
   
begin
  debounceButton1 : DebounceFilter
    port map (
      i_Clk    => i_Clk,
      i_buttonInput => i_Switch_1,
      o_debouncedButton => w_buttonState
    );

  clockProc : process (i_clk) is
  begin
    if (rising_edge(i_clk)) then
      r_switch1 <= w_buttonState; 
      -- Infers a flip flop and does NOT immediately take the value of w_buttonState
      -- This is why the next line is possible
      if w_buttonState = '0' and r_Switch1 = '1' then
        r_LEDState <= not r_LEDState;
      end if;
    end if;
  end process clockProc;

  o_LED_1 <= r_LEDState;

end Behavior;