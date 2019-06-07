class Parser
  def initialize(line)
    @line = line.split(' ')
    @command = @line[0]
    @segment = @line[1]
    @num = @line[2]
  end

  def parse
    @line.length == 3 ? write_push_or_pop : write_arithmetic
  end

  private

  def write_arithmetic

  end

  def write_push_or_pop
    case @segment
    when 'constant'
      handle_constant_segment
    when 'static'
      handle_static_segment
    when 'temp'
      handle_temp_segment
    when 'pointer'
      handle_pointer_segment
    else
      handle_regular_segments
    end
  end

  REGULAR_SEGMENTS = {'local' => 'LCL',
                      'argument' => 'ARG',
                      'this' => 'THIS',
                      'that' => 'THAT'}.freeze

  POP = ['@SP',
        'M=M-1',                             # Decrement the Stack Pointer
        'D=M',                               # set D register to value of the SP
        '@addr',
        'A=M',                               # get the addr value from M
        'M=D']                               # set RAM[addr[m]] to D]

  PUSH = ['@addr',
          'D=M',                              # grab M of addr
          '@SP',
          'A=M',                              # grab M of SP
          'M=D',                              # set the Memory of RAM[SP[M]] to D
          '@SP',                              # increment SP
          'M=M+1']
  def handle_regular_segments
    pop_or_push = @command == 'pop' ? POP : PUSH
    # e.g. pop local 2
    # addr = LCL + 2, SP--, *addr = *SP
    # e.g. push local i
    # addr = LCL + i, *SP = *addr, SP++
    p ["//#{@line.join(' ')}",
    "@#{REGULAR_SEGMENTS[@segment]}",          # Find pointer for segment
    "D=M+#{@num}",                              # Set D register to M + num
    '@addr',
    'M=D'] + pop_or_push                        # set addr variable to D
  end

  def handle_constant_segment
    # e.g. push constant i
    # *SP = i, SP++
    p ["//#{@line.join(' ')}",
    "@SP",
    "A=M",                        # set A register to SP[M]
    "M=#{@num}",                  # set A[M] to num
    "@SP",
    "M=M+1"]                      # increment SP
  end

  def handle_static_segment
    # e.g. pop static 5
    # D = stack.pop
    # @filename.5
    # M=D
  end

  def handle_temp_segment
    # same as the regular segments but 5 instead of LCL/ARG/THIS/THAT
  end

  def handle_pointer_segment
    # push pointer 0/1
    # *SP = THIS/THAT, SP++
  end
end
