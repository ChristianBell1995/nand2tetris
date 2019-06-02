class TrackSymbol
  def initialize(file)
    @file = file
    @symbol_table = {}
  end

  # @symbol_table = { 'symbol': 'binary' }

  def generate_symbol_table
    @symbol_table << PREDEFINED_SYMBOLS
    @symbol_table << label_symbols
    @symbol_table << variable_symbols
  end

  private

  PREDEFINED_SYMBOLS = {
    # ALL OF THE PREDEFINED HACK SYMBOLS
  }

  def label_symbols
    # Add symbols for all of the labels e.g. (LOOP)
    # Wherever there command appears we want to go to the address of the one after it
  end

  def variable_symbols
    # Add variable symbols to the symbol table if they are not already there starting at 16 and going upwards
  end
end