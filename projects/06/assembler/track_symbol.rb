class TrackSymbol
  def initialize(file)
    @file = file
    @symbol_table = {}
  end

  def generate_symbol_table
    @symbol_table.merge!(PREDEFINED_SYMBOLS)
    @symbol_table.merge!(label_symbols)
    variable_symbols
    @symbol_table
  end

  private

  PREDEFINED_SYMBOLS = {
    'R0' => 0,
    'R1' => 1,
    'R2' => 2,
    'R3' => 3,
    'R4' => 4,
    'R5' => 5,
    'R6' => 6,
    'R7' => 7,
    'R8' => 8,
    'R9' => 9,
    'R10' => 10,
    'R11' => 11,
    'R12' => 12,
    'R13' => 13,
    'R14' => 14,
    'R15' => 15,
    'SCREEN' => 16384,
    'KBD' => 24576,
    'SP' => 0,
    'LCL' => 1,
    'ARG' => 2,
    'THIS' => 3,
    'THAT' => 4
  }.freeze

  def label_symbols
    labels = {}
    line_count = 0
    label_count = 0
    @file.each_line do |line|
      # Add symbols for all of the labels e.g. (LOOP)
      if line.start_with?('(')
        end_of_label = line.index(')')
        label = line.slice(1..end_of_label - 1)
        # Number equals the line after the label is declared
        labels[label] = (line_count - label_count)
        label_count += 1
      end
      next if line.strip.start_with?('\n', '//') || line.strip == ''
      line_count += 1
    end
    labels
  end

  def variable_symbols
    address = 16
    @file.each_line do |line|
      # Add symbols for all of the variables (@)
      if line.strip.start_with?('@')
        formatted_var = line.strip[1..-1]
        # Skip if the variable already exists in the symbol table or is a number
        next if @symbol_table.has_key?(formatted_var) || formatted_var.match(/^[0-9]*$/)
        @symbol_table[formatted_var] = address
        address += 1
      end
    end
  end
end