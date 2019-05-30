# Run ruby main.rb 'path/filename' to run program

require_relative 'parser'

file = open ARGV.first
file_to_read = file.read.gsub!(/\r\n?/, "\n")
p file.filename
new_file_lines = []
file_to_read.each_line do |line|
  parser = Parser.new(line)
  new_file_lines << parser.parse
end

# To Do write the new file with lines of binary