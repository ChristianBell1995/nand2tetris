# Run ruby main.rb 'path/filename' to run program

require_relative 'parser'

file = open ARGV.first
file_to_read = file.read.gsub!(/\r\n?/, "\n")
new_file_lines = []
file_to_read.each_line do |line|
  parser = Parser.new(line)
  new_file_lines << parser.parse
end

formatted_lines = new_file_lines.reject(&:empty?)

File.open("test_file.hack", "w+") do |f|
  formatted_lines.each { |element| f.puts(element) }
end
