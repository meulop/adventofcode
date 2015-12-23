require 'pp'

$graph = Hash.new
$cache = Hash.new

# First read the file and build structures
File.open('data/dec9/input.txt').each do |line|
  line.chomp.match(/^(?<l1>.+) to (?<l2>.+) = (?<dist>\d+)$/) do |m|
    $graph[m[:l1]] ||= Hash.new()
    $graph[m[:l2]] ||= Hash.new()
    $graph[m[:l2]][m[:l1]] = $graph[m[:l1]][m[:l2]] = m[:dist].to_i
  end
end

$locations = $graph.keys

def tsp(vertset)
  if $cache[vertset.sort]
    $cache[vertset.sort]
  else
    case vertset.length
    when 1
      $cache[vertset.sort] = 0
    when 2
      $cache[vertset.sort] = $graph[vertset[0]][vertset[1]]
    else
      $cache[vertset.sort] = vertset.map do |v1|
        otherverts = vertset.reject{ |v| v==v1 }
        otherverts .map do |v2|
          $graph[v1][v2] + tsp(otherverts.reject{|v| v== v2})
        end.min
      end.min
    end
  end
end


pp tsp($graph.keys.sort)


pp $cache

pp tsp($graph.keys.sort)