require 'pp'

graph = Hash.new()

# First read the file and build structures
File.open('data/dec9/input.txt').each do |line|
  line.chomp.match(/^(?<l1>.+) to (?<l2>.+) = (?<dist>\d+)$/) do |m|
    graph[m[:l1]] ||= Hash.new()
    graph[m[:l1]][m[:l2]] = m[:dist].to_i
    graph[m[:l2]] ||= Hash.new()
    graph[m[:l2]][m[:l1]] = graph[m[:l1]][m[:l2]]
  end
end

pp graph