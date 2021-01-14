# PONG-VHDL

## description
PONG game implemented with VHDL for use with [Go Board](https://www.nandland.com/goboard/introduction.html) FPGA w/ VGA output.

## function

1. Classic 2-Player PONG game running through the Go Board's Lattice iCE40HX1k FPGA.
2. Inputs through keyboard (using UART) and the on-board buttons for player paddle control.
3. Outputs the game through VGA display and the score through the on-board seven segment display.
4. Change color by pressing Q,W,E,R and, T to start the game using Tera Term (115,200 Baud rate). Use respective buttons to control the paddles on each side.

## installation
1. Clone the repo and use the 'PONG v1.bin' bitmap to program your Go Board through [Diamond Programmer](http://www.latticesemi.com/Products/DesignSoftwareAndIP/FPGAandLDS/LatticeDiamond).
2. You can also use the .vhd files to create your own bitmap using [icecube2](http://www.latticesemi.com/Products/DesignSoftwareAndIP/FPGAandLDS/iCEcube2.aspx).
3. Follow NandLand's [guide](https://www.nandland.com/goboard/your-first-go-board-project.html) on how to do the above steps.

## what I learned

1. Testbenching, combinational and sequential behavioral code, FSMs in VHDL.
2. Digital button debounce filtering implemented through an FPGA.
3. UART Rx/Tx protocol.
4. VGA interface timing and output.
5. The overall FPGA/VHDL design process.

## notes

For use with Go Board. Using this on another FPGA will need to have the IO identifiers adjusted to match the constraints file and use a 25MHz clock to drive the UART and VGA properly. For anyone also using the Go Board. VHDL is not case sensitive but iCEcube2 is! Your inputs and outputs must exactly match the ones on the constraint file.

I wanted to further my digital design learning, so I went ahead and bought a Go Board which is very accessible for beginners and chose to learn VHDL because it's the first HDL introduced in my university. I followed the tutorials on [NandLand](https://www.nandland.com/goboard/introduction.html), but chose to modify some parts and made my own modules so I can try stuff on my own. For this project, I chose to use the provided UART Rx/Tx module as suggested. I plan on trying to implement it on my own and update accordingly in the future. 

I wasn't a fan of having 3 different modules for VGA, I've made my own VGA Driver module that essentially combines the 'Sync Pulse', 'Sync to Count' and 'Sync Porch' modules with some additional logic to properly drive the RGB signals at the right time (RGB signals MUST be low during inactive time). This is used to directly drive the VGA port. Can be used for other projects on the Go Board or other FPGA dev boards as long as you use a 25MHz clock to drive it.

The creator of the Go Board also left some suggestions on improving the Pong game. I implemented the color selecting through keyboard and UART and, used the seven segment display as a score tracker.


## future improvements
1. Rainbow mode - With 9 bits of RGB, it is possible to cycle through all 512 colors as the game goes or when someone scores a point.
2. AI - It should be pretty straightforward to implement simple AI that checks the ball's Y coordinate and adjust itself accordingly.
3. Additional colors - It's trivial to add more colors at this point. Just need to expand the width of the output of the UART decoder and include the additional colors in the Color MUX.
4. Higher resolution - the Go Board can output 640x480 at 60Hz but currently the game is downscaled to 40x30. A few edits to the constants in the package and the signals, it should be easy to upscale it.

## images
PONG Circuit Diagram
![PONG Circuit Diagram](https://raw.githubusercontent.com/almazarrafael/PONG-VHDL/main/RTL.PNG?token=ALHDSCTXKZRLWHOMZA2I7U3ABHZOA)

## resources

### Debounce:

[DigiKey Debounce](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=4980758)

[NandLand Debounce](https://www.nandland.com/goboard/debounce-switch-project.html)

### UART:

[DigiKey UART](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=59507062)

[NandLand UART Reciever](https://www.nandland.com/goboard/uart-go-board-project-part1.html)

[NandLand UART Transmitter](https://www.nandland.com/goboard/uart-go-board-project-part2.html)

### VGA:

[DigiKey VGA](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=15925278)

[NandLand VGA](https://www.nandland.com/goboard/vga-introduction-test-patterns.html)

### PONG:

[fpga4fun PONG](https://www.fpga4fun.com/PongGame.html)

[NandLand PONG](https://www.nandland.com/goboard/pong-game-in-fpga-with-go-board-vga.html)
