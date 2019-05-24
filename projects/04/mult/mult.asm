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

@1
D=A
@i
M=D     // set i to 1

(LOOP)
  @i
  D=M     // get i
  @R0
  D=M-D   // RO - i
  @END
  D;JEQ   // if i - RO == 0 END \ EXIT LOOP

  @SUM
  D=M     // get sum
  @R1
  M=D+M   // R1 + sum

  @1
  D=A
  @i
  M=M+D   // increment i

  @LOOP
  0;JMP   // go to the start of the loop

(SUM)
  @4
  D=A
  @R2
  M=D     // set sum to 0

(END)
  @END
  0;JMP

