# Run ruby main.rb 'path/filename' to run program

require_relative 'parser'

file = open ARGV.first
assembly_code = []
# Then parse each line into assembly code
file.read.each_line do |line|
  line.gsub!(/\r\n?/, "")
  next if line.start_with?('//') || line == ''
  parser = Parser.new(line)
  assembly_code << parser.parse
end

# filename = File.basename(file, ".asm")
# formatted_lines = new_file_lines.reject(&:empty?)

# File.open("#{filename}.asm", "w+") do |f|
#   formatted_lines.each { |element| f.puts(element) }
# end
