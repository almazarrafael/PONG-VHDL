-- Note: uses VGA_Sync_Pulses.vhd to generate H-Sync, V-Sync signals.
library ieee;
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;

entity Sync_To_Count_tb is
end entity Sync_To_Count_tb;

architecture Behavior of Sync_To_Count_tb is
    component Sync_To_Count is
        generic (
          g_totalCols  : integer; -- 800
          g_totalRows  : integer -- 525
        );
        port (
          i_clk : in std_logic;
          i_HSync : in std_logic;
          i_VSync : in std_logic;
          o_HSync : out std_logic;
          o_VSync : out std_logic;
          o_colCount : out std_logic_vector(9 downto 0);
          o_rowCount : out std_logic_vector(9 downto 0)
        ) ;
    end component Sync_To_Count;

    component VGA_Sync_Pulses is
        generic (
            g_totalCols  : integer; -- 800
            g_totalRows  : integer; -- 525
            g_activeCols : integer; -- 640
            g_activeRows : integer  -- 480
        );
        port (
          i_clk      : in  std_logic;
          o_HSync    : out std_logic;
          o_VSync    : out std_logic;
          o_colCount : out std_logic_vector(9 downto 0);
          o_rowCount : out std_logic_vector(9 downto 0)
        ) ;
    end component VGA_Sync_Pulses;

    signal i_clk_sig, o_HSync_sig, o_VSync_sig : std_logic := '0';
    signal o_colCount_sig, o_rowCount_sig : std_logic_vector(9 downto 0) := (others => '0');
    signal w_HSync, w_VSync : std_logic;

begin

    UUT : Sync_To_Count
    generic map (
        g_totalCols  => 800,
        g_totalRows  => 525
    )
    port map (
        i_clk => i_clk_sig,
        i_HSync => w_HSync,
        i_VSync => w_VSync,
        o_HSync => o_HSync_sig,
        o_VSync => o_VSync_sig,
        o_colCount => o_colCount_sig,
        o_rowCount => o_rowCount_sig
    );

    syncGen : VGA_Sync_Pulses
    generic map (
        g_totalCols  => 800,
        g_totalRows  => 525,
        g_activeCols => 640,
        g_activeRows => 480
    )
    port map (
        i_clk => i_clk_sig,
        o_HSync    => w_HSync,
        o_VSync    => w_VSync,
        o_colCount => open,
        o_rowCount => open
    );

    i_clk_sig <= not i_clk_sig after 20 ns;

    process is
    begin
        wait for 5 us;
        assert false report "Test Complete" severity failure;
    end process;

end architecture Behavior ; -- Behavior