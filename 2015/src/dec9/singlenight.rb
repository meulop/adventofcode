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
File.open('data/dec9/input.txt').each do |line|
  line.chomp.match(/^(?<l1>.+) to (?<l2>.+) = (?<dist>\d+)$/) do |m|
    $graph[m[:l1]] ||= Hash.new()
    $graph[m[:l2]] ||= Hash.new()
    $graph[m[:l2]][m[:l1]] = $graph[m[:l1]][m[:l2]] = m[:dist].to_i
  end
end


$locations = $graph.keys


def tsp(start,vertset)
  vertset.sort!
  $cache[start] ||= Hash.new
  unless $cache[start][vertset]
    $cache[start][vertset] = case vertset.length
    when 1
      $graph[start][vertset[0]]
    else
      vertset.map do |v|
        $graph[start][v] + tsp(v,vertset.reject {|v2| v2==v})
      end.send($sym)
    end
  end
  $cache[start][vertset]
end


pp $locations.map { |s|
  tsp(s,$locations.reject {|v| v==s})
}.send($sym)