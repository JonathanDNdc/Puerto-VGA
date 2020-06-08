# Puerto VGA
## Código
- vga.vhdl
- vga_sync.vhdl
- pixel_generation.vhdl

### vga_sync
Este componente se encarga del funcionamiento de la sincronización.

### pixel_generation
Este componente se encarga de la generación de pixeles.

### vga
Interface que engloba los componentes.


##
Para tener una resolución de 3 bits por cada color primero se tiene que modificar el código.

Se quiere cambiar de un bit por color a 3 bits por color, por lo que se cambiaría esto en los puertos:
```VHDL
red, green, blue : in std_logic;
rgb              : out std_logic_vector(2 downto 0);
```
a esto:
```VHDL
red, green, blue : in std_logic_vector(2 downto 0);
rgb              : out std_logic_vector(8 downto 0);
```

Y en **pixel_generation** se cambiaría esto:
```VHDL
rgb(2) <= red and video_on;
rgb(1) <= green and video_on;
rgb(0) <= blue and video_on;
```
a esto
```VHDL
rgb(8) <= red(2) and video_on;
rgb(7) <= red(1) and video_on;
rgb(6) <= red(0) and video_on;
rgb(5) <= green(2) and video_on;
rgb(4) <= green(1) and video_on;
rgb(3) <= green(0) and video_on;
rgb(2) <= blue(2) and video_on;
rgb(1) <= blue(1) and video_on;
rgb(0) <= blue(0) and video_on;
```
Después de estos cambios en el código se requiere una combinación de resistencias para convertir la señal de digital a analogica. Se utiliza una resistencia de **510Ω**, **1KΩ** y **2KΩ** para los bits de cada color, de MSB a LSB respectivamente.
