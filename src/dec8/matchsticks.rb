require 'pp'

# This one's easy - cheat and use eval!
a=File.open("data/dec8/input.txt").readlines.collect do |line|
  line.chomp!
  line.length - (eval "#{line}.length")
end.reduce(:+)

pp "Part 1: #{a}"

# Less easy - must sub for existing '\' and '"' chars, but in
# the right order or we may duplicate the backslash in each '\"'
b=File.open("data/dec8/input.txt").readlines.collect do |line|
  line.chomp!
  line.gsub(/\\/,'\\\\\\').gsub('"','\"').insert(0,'"').insert(-1,'"').length - line.length
end.reduce(:+)

pp "Part 2: #{b}"