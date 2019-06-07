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

  SP = 'R0'
  REGULAR_SEGMENTS = {'local' => 'LCL',
                      'argument' => 'ARG',
                      'this' => 'THIS',
                      'that' => 'THAT'}.freeze

  def write_push_or_pop
    p REGULAR_SEGMENTS.has_key?(@segment)
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

  POP = ["@SP",
        "M=M-1",                             # Decrement the Stack Pointer
        "D=M",                               # set D register to value of the SP
        "@addr",
        "A=M",                               # get the addr value from M
        "M=D"]                               # set RAM[addr[m]] to D]

  def handle_regular_segments
    if @command == 'pop'
      # e.g. pop local 2
      # addr = LCL + 2, SP--, *addr = *SP
      ["@#{REGULAR_SEGMENTS[@segment]}",          # Find pointer for segment
      "D=M+#{@num}",                              # Set D register to M + num
      "@addr",
      "M=D"] + POP                                # set temp variable address to D
    else
      # e.g. push local i
      # addr = LCL + i, *SP = *addr, SP++

    end
  end

  def handle_constant_segment
    # e.g. push constant i
    # *SP = i, SP++
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
