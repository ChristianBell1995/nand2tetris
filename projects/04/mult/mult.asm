// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// PSEUDO CODE:
  // R0 * R1 = R2
  // sum = 0
  // for(i = 1, i == R0, i++)
    // sum + R1
  // return sum

@0
D=A
@times
M=D     // set times to 0

@0
D=A
@sum
M=D     // set sum (R2) to 0

(LOOP)
  @times
  D=M     // get times
  @R0
  D=M-D   // RO - times
  @STOP
  D;JEQ   // if times - RO == 0 END \ EXIT LOOP

  @R1
  D=M   // get value of R1
  @sum
  M=D+M     // add the value of R1 to sum (R2)

  @1
  D=A
  @times
  M=M+D   // increment times

  @LOOP
  0;JMP   // go to the start of the loop

(STOP)
  @sum   // get value of sum
  D=M
  @R2
  M=D   // move variable sum into register 2

(END)
  @END
  0;JMP

