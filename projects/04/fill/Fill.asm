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

// Begin loop (LOOPONE)

  // Listen to KBD, read the contents of this address
  // if KBD = 0
        // start loop to set entire screen to black
        // rows = number of rows (256)
        // columns = number of columns (512)
        // rows x columns / 16 = 8192

        // loop 8192 times each time taking the address[count] of a pixel
        // set each pixel to -1

        // call LOOPONE
  // else KBD = another value
        // set screen to white
        // call LOOPONE

// End loop (call start of the loop again in infinite loop)

@SCREEN
D=A
@address
M=D             // get the screens base address

@8192          // number of rows (256) x number of columns (512) / 16 = 8192
D=A
@bits
M=D            // set the value of bits to 8192

(LOOPONE)
      @0
      D=A
      @counter
      M=D          // sets counter to zero

      @KBD        
      D=M         // get input of keyboard
      @LOOPBLACK
      D;JGT       // if kbd = 1 (a key is pressed) go to LOOPBLACK
      @LOOPWHITE
      D;JEQ       // if kbd = 0 (a key is not pressed) go to LOOPWHITE

      @LOOPONE
      0;JMP        // go back to the start of the loop

(LOOPWHITE)
      @KBD
      D=M          // get value of keyboard
      @LOOPONE
      D;JGT        // if keyboard is greater than 0 go back to loop one

      @counter
      D=M        // get the value of the counter
      @bits
      D=M-D      
      @LOOPONE
      D;JEQ       // if bits - counter = 0 go back to LOOPONE

      @counter
      D=M        // get the value of the counter
      @address
      D=D+M         // add the value of the counter to the adress of the screen
      A=D           // set the address register to D
      M=0          // set the address at M to 0 (making the screen white)

      @counter
      M=M+1         // increment the counter

      @LOOPWHITE
      0;JMP        // go back to the start of the loop;


(LOOPBLACK)
      @KBD
      D=M          // get value of keyboard
      @LOOPONE
      D;JEQ        // if keyboard is equal to 0 go back to loop one

      @counter
      D=M        // get the value of the counter
      @bits
      D=M-D      
      @LOOPONE
      D;JEQ       // if bits - counter = 0 go back to LOOPONE

      @counter
      D=M        // get the value of the counter
      @address
      D=D+M         // add the value of the counter to the adress of the screen
      A=D           // set the address register to D
      M=-1          // set the address at M to 0 (making the screen white)

      @counter
      M=M+1         // increment the counter

      @LOOPBLACK
      0;JMP        // go back to the start of the loop;

