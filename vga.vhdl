library ieee;
use ieee.std_logic_1164.all;

entity vga is
    generic(
        HD : integer := 640; -- Visible area h.
        HF : integer := 16 ; -- Front porch h.
        HB : integer := 48 ; -- Back porch h.
        HR : integer := 96 ; -- Sync pulse h.
        VD : integer := 480; -- Visible area v.
        VF : integer := 10;  -- Front porch v.
        VB : integer := 33;  -- Back porch v.
        VR : integer := 2    -- Sync pulse v.
    );
    port(
        clk            : in  std_logic;
        red,green,blue : in  std_logic;
        rgb            : out std_logic_vector(2 downto 0);
        hsync, vsync   : out std_logic;
        clk_vga        : out std_logic
    );
end entity;

architecture arch of vga is

    component vga_sync is
        generic(
            HD : integer := 640; -- Visible area h.
            HF : integer := 16 ; -- Front porch h.
            HB : integer := 48 ; -- Back porch h.
            HR : integer := 96 ; -- Sync pulse h.
            VD : integer := 480; -- Visible area v.
            VF : integer := 10;  -- Front porch v.
            VB : integer := 33;  -- Back porch v.
            VR : integer := 2    -- Sync pulse v.
        );
        port(
            clk          : in  std_logic;
            hsync, vsync : out std_logic;
            video_on     : out std_logic
        );
    end component;

    component pixel_generation is
        port(
            clk            : in  std_logic;
            red,green,blue : in  std_logic;
            video_on       : in  std_logic;
            rgb            : out std_logic_vector(2 downto 0)
        );
    end component;

    signal video_on : std_logic;

begin

    clk_vga <= clk; --- clock es de 25Mhz

    vs : vga_sync
        generic map(HD, HF, HB, HR, VD, VF, VB, VR)
        port map(clk, hsync, vsync, video_on);

    pg : pixel_generation
        port map(clk, red, green, blue, video_on, rgb);

end arch;
