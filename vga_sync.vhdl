library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_sync is
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
end entity;

-- 640x480
architecture arch of vga_sync is

    signal hs, vs                 : std_logic;
    signal video_on_v, video_on_h : std_logic;

    constant h_period : integer := HD + HF + HB + HR;
    constant v_period : integer := VD + VF + VB + VR;

begin


    video_on <= video_on_h and video_on_v;

    process
        variable hcount : integer range 0 to h_period - 1 := 0;
        variable vcount : integer range 0 to v_period -1  := 0;
    begin
        if rising_edge(clk) then

            -- horizontal counter
            if hcount = h_period - 1 then
                hcount := 0;
            else
                hcount := hcount + 1;
            end if;
            -- hsync
            if hcount >= (HD+HF) and hcount <= (HD+HF+HR-1) then
                hs <= '0';
            else
                hs <= '1';
            end if;

            -- vertical counter
            if vcount = v_period - 1 then
                vcount := 0;
            else
                vcount := vcount + 1;
            end if;
            -- vsync
            if vcount >= (VD+VF) and vcount <= (VD+VF+VR-1) then
                vs <= '0';
            else
                vs <= '1';
            end if;


            if hcount < HD then
                video_on_h <= '1';
            else
                video_on_h <= '0';
            end if;

            if vcount < VD then
                video_on_v <= '1';
            else
                video_on_v <= '0';
            end if;

            hsync <= hs;
            vsync <= vs;
        end if;
    end process;

end arch;
