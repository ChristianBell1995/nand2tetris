// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// Begin loop

  // Listen to KBD, read the contents of this address
  // if KBD = 0
        // start loop to set entire screen to black
        // n = RAM[0] (number of pixels in screen)
        // i = number of rows
        //
  // else KBD = another value
        // set screen to white

// End loop (call start of the loop again in infinite loop)
