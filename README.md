# Pong-VHDL

## description
Pong game implemented with VHDL for use with Go Board FPGA w/ VGA output

## function

1. Classic Pong game running through the Go Board.
2. Inputs through keyboard (using UART) and the on board buttons for paddle control.
3. Outputs the game through VGA and the score through the on board seven segment display.

## what I learned

1. VHDL syntax, testbenching, behavioral code
2. Debouncing through VHDL
3. UART protocol
4. VGA interface output and timing
5. Overall FPGA design process

## notes

I wanted to further my digital design learning, so I went ahead and bought a Go Board which is very accessible for beginners and chose to learn VHDL because it's the first HDL introduced in my university. I blindly followed the tutorials on [NandLand](https://www.nandland.com/goboard/introduction.html) so that I can try stuff on my own and only look at the resources there as a safety net. For this project, I chose to use the provided UART Rx/Tx module as suggested. Will try to implement it on my own and update in the future. The creator of the Go Board also left some suggestions on improving the Pong game. I will try to implement the color selecting through keyboard and UART and, use the seven segment display as a score tracker.

## images

pictures

## resources
[DigiKey Debounce](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=4980758)

[DigiKey UART](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=59507062)

[DigiKey VGA](https://www.digikey.com/eewiki/pages/viewpage.action?pageId=15925278)

[NandLand UART Reciever](https://www.nandland.com/goboard/uart-go-board-project-part1.html)

[NandLand UART Transmitter](https://www.nandland.com/goboard/uart-go-board-project-part2.html)

[NandLand VGA](https://www.nandland.com/goboard/vga-introduction-test-patterns.html)
