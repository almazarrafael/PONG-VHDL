library ieee;
use ieee.std_logic_1164.all;

entity VGA_FPGATest is
  port (
    i_Clk       : in std_logic;
    i_Switch_1  : in std_logic;
    i_Switch_2  : in std_logic;
    i_Switch_3  : in std_logic;
    i_Switch_4  : in std_logic;
    o_VGA_HSync : out std_logic;
    o_VGA_VSync : out std_logic;
    o_VGA_Red_0 : out std_logic;
    o_VGA_Red_1 : out std_logic;
    o_VGA_Red_2 : out std_logic;
    o_VGA_Grn_0 : out std_logic;
    o_VGA_Grn_1 : out std_logic;
    o_VGA_Grn_2 : out std_logic;
    o_VGA_Blu_0 : out std_logic;
    o_VGA_Blu_1 : out std_logic;
    o_VGA_Blu_2 : out std_logic
  ) ;
end VGA_FPGATest;

architecture Behavior of VGA_FPGATest is
    signal w_colorSel : std_logic_vector(8 downto 0);
    signal w_red, w_grn, w_blu : std_logic_vector(2 downto 0);
    signal w_red2, w_grn2, w_blu2 : std_logic_vector(2 downto 0);
    signal w_HSync, w_VSync : std_logic;

begin
    
    vgaDriver : entity work.VGA_Driver
    generic map (
        g_totalCols  => 800,
        g_totalRows  => 525,
        g_activeCols => 640,
        g_activeRows => 480
    )
    port map (
        i_clk => i_Clk,
        i_red => w_colorSel(8 downto 6),
        i_grn => w_colorSel(5 downto 3),
        i_blu => w_colorSel(2 downto 0),
        o_red       => w_red2,
        o_grn       => w_grn2,
        o_blu       => w_blu2,
        o_HSync     => w_HSync,
        o_VSync     => w_VSync,
        o_colCount  => open,
        o_rowCount  => open
    );

    o_VGA_HSync <= w_HSync;
    o_VGA_VSync <= w_VSync;
    

    o_VGA_Red_0 <= w_red2(0);
    o_VGA_Red_1 <= w_red2(1);
    o_VGA_Red_2 <= w_red2(2);
    
    o_VGA_Grn_0 <= w_grn2(0);
    o_VGA_Grn_1 <= w_grn2(1);
    o_VGA_Grn_2 <= w_grn2(2);
    
    o_VGA_Blu_0 <= w_blu2(0);
    o_VGA_Blu_1 <= w_blu2(1);
    o_VGA_Blu_2 <= w_blu2(2);

    w_colorSel <= "111000111" when i_Switch_1 = '1' else
                  "111000000" when i_Switch_2 = '1' else
                  "000111000" when i_Switch_3 = '1' else
                  "000000111" when i_Switch_4 = '1' else
                  "000000000";

end Behavior ; -- Behavior