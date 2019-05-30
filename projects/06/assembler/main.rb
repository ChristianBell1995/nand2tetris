# Run ruby main.rb 'path/filename' to run program

require_relative 'parser'

file = open ARGV.first
file_to_read = file.read.gsub!(/\r\n?/, "\n")
file_to_read.each_line do |line|
  parser = Parser.new(line)
  parser.parse
  p parser.parse
end