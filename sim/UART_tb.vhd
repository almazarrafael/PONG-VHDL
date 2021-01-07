----------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity UART_TB is
end UART_TB;
 
architecture Behave of UART_TB is
   
  -- Test Bench uses a 25 MHz Clock
  constant c_CLK_PERIOD : time := 40 ns;
  
  -- Want to interface to 115200 baud UART
  -- 25000000 / 115200 = 217 Clocks Per Bit.
  constant c_CLKS_PER_BIT : integer := 217;
 
  constant c_BIT_PERIOD : time := 8680 ns;
   
  signal r_Clock     : std_logic                    := '0';
  signal r_TX_DV     : std_logic                    := '0';
  signal r_TX_Byte   : std_logic_vector(7 downto 0) := (others => '0');
  signal w_TX_Serial : std_logic;
  signal w_TX_Done   : std_logic;
  signal w_TX_Active : std_logic;
  signal w_RX_DV     : std_logic;
  signal w_RX_Byte   : std_logic_vector(7 downto 0);
  signal r_RX_Serial : std_logic := '1';
  signal w_UART_Data : std_logic;
   
begin
 
  -- Instantiate UART transmitter
  UART_TX_INST : entity work.UART_TX
    generic map (
      g_CLKS_PER_BIT => c_CLKS_PER_BIT
      )
    port map (
      i_Clk       => r_Clock,
      i_TX_DV     => r_TX_DV,
      i_TX_Byte   => r_TX_Byte,
      o_TX_Active => w_TX_Active,
      o_TX_Serial => w_TX_Serial,
      o_TX_Done   => w_TX_Done
      );
 
  -- Instantiate UART Receiver
  UART_RX_INST : entity work.UART_RX
    generic map (
      g_CLKS_PER_BIT => c_CLKS_PER_BIT
      )
    port map (
      i_Clk       => r_Clock,
      i_RX_Serial => w_UART_Data,
      o_RX_DV     => w_RX_DV,
      o_RX_Byte   => w_RX_Byte
      );
 
  -- Keeps the UART Receive input high (default) when
  -- UART transmitter is not active
  w_UART_Data <= w_TX_Serial when w_TX_Active = '1' else '1';
 
  r_Clock <= not r_Clock after c_CLK_PERIOD/2;
   
  process is
  begin
  
    -- Tell the UART to send a command.  Exercise TX
    wait until rising_edge(r_Clock);
    wait until rising_edge(r_Clock);
    r_TX_DV   <= '1';
    r_TX_Byte <= X"37";
    wait until rising_edge(r_Clock);
    r_TX_DV   <= '0';
    
    -- Check that corrrect byte was received
    wait until rising_edge(w_RX_DV);
    
    -- Check that the correct command was received
    if w_RX_Byte = X"37" then
      report "Test Passed - Correct Byte Received" severity note;
    else
      report "Test Failed - Incorrect Byte Received" severity note;
    end if;
 
    assert false report "Tests Complete" severity failure;
     
  end process;
   
end Behave;
