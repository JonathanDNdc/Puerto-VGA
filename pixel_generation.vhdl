library ieee;
use ieee.std_logic_1164.all;

entity pixel_generation is
    port(
        clk            : in  std_logic;
        red,green,blue : in  std_logic;
        video_on       : in  std_logic;
        rgb            : out std_logic_vector(2 downto 0)
    );
end entity;

architecture arch of pixel_generation is
begin

    process
    begin
        if rising_edge(clk) then
            rgb(0) <= red and video_on;
            rgb(1) <= green and video_on;
            rgb(2) <= blue and video_on;
        end if;
    end process;

end arch;
