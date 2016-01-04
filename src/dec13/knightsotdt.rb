require 'pp'

$graph = Hash.new
$cache = Hash.new

$sym = case ARGV[0]
  when nil
    puts("Must specify a function!")
    exit 1
  when "min"
    :min
  when "max"
    :max
  else
    puts("unknown function '#{ARGV[0]}'")
    exit 1
end



# First read the file and build structures
File.open('data/dec13/input.txt').each do |line|
  line.chomp.match(/^(?<p1>\w+) would (?<action>gain|lose) (?<deltah>\d+).*to (?<p2>\w+).$/) do |m|
    $graph[m[:p1]] ||= Hash.new(0)
    $graph[m[:p2]] ||= Hash.new(0)
    $graph[m[:p2]][m[:p1]] = $graph[m[:p1]][m[:p2]] += (m[:action] == "gain" ? m[:deltah].to_i : "-#{m[:deltah]}".to_i)
  end
end

$people = $graph.keys

# Part 2 section 
$graph["Dave"] = Hash.new(0)
$people.each do |p|
  $graph[p]["Dave"] = 0
  $graph["Dave"][p] = 0
end

$people << "Dave"

# End Part 2 section

def unrolled_happiness(perm)
  unless $cache[perm]
    $cache[perm] = case perm.length
    when 1
      0
    when 2
      $graph[perm[0]][perm[1]]
    else
      $graph[perm[0]][perm[1]] + unrolled_happiness(perm[1..-1])
    end
  end
  $cache[perm]
end


pp $people.permutation.map { |p|
  unrolled_happiness(p) + $graph[p[0]][p[-1]]
}.send($sym)