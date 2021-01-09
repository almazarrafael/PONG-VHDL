# PONG-VHDL

## description
Pong game implemented with VHDL for use with Go Board FPGA w/ VGA output

## function

1. Classic 2-Player PONG game running through the Go Board's Lattice iCE40HX1k FPGA.
2. Inputs through keyboard (using UART) and the on board buttons for player paddle control.
3. Outputs the game through VGA display and the score through the on board seven segment display.
4. Change color by pressing Q,W,E,R and, T to start the game using Tera Term (115,200 Baud rate). Use respective buttons to control the paddles on each side.

## installation
1. Clone the repo and use the Pong.bin bitmap to program your Go Board through Diamond Programmer.
2. You can also use the .vhd files to create your own bitmap using icecube2.
3. Follow NandLand's [guide](https://www.nandland.com/goboard/your-first-go-board-project.html) on how to do the above steps.

## what I learned

1. VHDL, testbenching, combinational and sequential behavioral code
2. Button debounce filtering through VHDL
3. UART Rx/Tx protocol
4. VGA interface output and timing
5. Overall FPGA design process

## notes

I wanted to further my digital design learning, so I went ahead and bought a Go Board which is very accessible for beginners and chose to learn VHDL because it's the first HDL introduced in my university. I blindly followed the tutorials on [NandLand](https://www.nandland.com/goboard/introduction.html) so that I can try stuff on my own and only look at the resources there as a safety net. For this project, I chose to use the provided UART Rx/Tx module as suggested. I plan on trying to implement it on my own and update accordingly in the future. 

The creator of the Go Board also left some suggestions on improving the Pong game. I will try to implement the color selecting through keyboard and UART and, use the seven segment display as a score tracker.

For use with Go Board. Using this on another FPGA will need to have the IO identifiers adjusted to match the constraints file and the UART and VGA timing values recalculated to match its clock frequency.

## images

pictures

## resources
[DigiKey Debounce](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=4980758)

[DigiKey UART](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=59507062)

[DigiKey VGA](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=15925278)

[NandLand UART Reciever](https://www.nandland.com/goboard/uart-go-board-project-part1.html)

[NandLand UART Transmitter](https://www.nandland.com/goboard/uart-go-board-project-part2.html)

[NandLand VGA](https://www.nandland.com/goboard/vga-introduction-test-patterns.html)
