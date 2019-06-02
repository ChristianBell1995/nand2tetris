class Parser
  def initialize(line)
    @line = line.strip
    @line_bin = ''
    @dest_bin = '000'
    @jump_bin = '000'
    @comp_bin = ''
    @a_bin = ''
  end

  def parse
    return '' if @line.start_with?('\n') || @line.start_with?('//') || @line == ''
    if @line.start_with?('@')
      a_instructions
    else
      c_instructions
    end
  end

  private

  def a_instructions
    integer = @line[1..-1].to_i
    @line_bin = integer.to_s(2)
    @line_bin = @line_bin.rjust(16, '0')
  end

  def c_instructions
    find_dest_bin
    find_jump_bin
    find_comp_bin
    "111#{@a_bin}#{@comp_bin}#{@dest_bin}#{@jump_bin}".gsub(/\s+/, "")
  end

  DESTINATION_MAPPING = {
    'M' => '001',
    'D' => '010',
    'MD' => '011',
    'A' => '100',
    'AM' => '101',
    'AD' => '110',
    'AMD' => '111'
  }.freeze

  def find_dest_bin
    if @line.include? '='
      dest = @line.split(/=/).first
      @dest_bin = DESTINATION_MAPPING[dest]
    end
  end

  JUMP_MAPPING = {
    'JGT' => '001',
    'JEQ' => '010',
    'JGE' => '011',
    'JLT' => '100',
    'JNE' => '101',
    'JLE' => '110',
    'JMP' => '111'
  }.freeze

  def find_jump_bin
    if @line.include? ';'
      jump = @line.split(/;/).last[0..2]
      @jump_bin = JUMP_MAPPING[jump]
    end
  end

  COMP_MAPPING = {
    '0' => '101010',
    '1' => '111111',
    '-1' => '111010',
    'D' => '001100',
    'A' => '110000',
    'M' => '110000',
    '!D' => '0 0 1 1 0 1',
    '!M' => '1 1 0 0 0 1',
    '!A' => '1 1 0 0 0 1',
    '-D' => '0 0 1 1 1 1',
    '-A' => '1 1 0 0 1 1',
    '-M' => '1 1 0 0 1 1',
    'D+1' => '0 1 1 1 1 1',
    'A+1' => '1 1 0 1 1 1',
    'M+1' => '1 1 0 1 1 1',
    'D-1' => '0 0 1 1 1 0',
    'A-1' => '1 1 0 0 1 0',
    'M-1' => '1 1 0 0 1 0',
    'D+A' => '0 0 0 0 1 0',
    'D+M' => '0 0 0 0 1 0',
    'D-A' => '0 1 0 0 1 1',
    'D-M' => '0 1 0 0 1 1',
    'A-D' => '0 0 0 1 1 1',
    'M-D' => '0 0 0 1 1 1',
    'D&A' => '0 0 0 0 0 0',
    'D&M' => '0 0 0 0 0 0',
    'D|A' => '010101',
    'D|M' => '010101'
  }.freeze

  def find_comp_bin
    if @line.include? ';'
      comp = @line.split(/;/).first
    elsif @line.include? '='
      comp = @line.split(/=/).last
    end
    @comp_bin = COMP_MAPPING[comp]
    find_a_bin(comp)
  end

  SET_A_TO_ONE = ['M', '!M', '-M', 'M+1', 'M-1', 'D+M', 'D-M', 'M-D', 'D&M', 'D|M'].freeze

  def find_a_bin(comp)
    @a_bin = SET_A_TO_ONE.include?(comp) ? '1' : '0'
  end
end
