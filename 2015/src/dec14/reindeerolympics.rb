require 'pp'

$finishtype=ARGV[0]
$finishpoint=ARGV[1].to_i

$reindeer = Hash.new

File.open('data/dec14/input.txt').each do |line|
  line.chomp.match(/(?<n>\w+) can fly (?<v>\d+) km\/s for (?<t>\d+) seconds.*for (?<r>\d+) seconds/) do |m|
    n=m[:n]
    v=m[:v].to_i
    t=m[:t].to_i
    r=m[:r].to_i
    cyc = t + r
    puts "#{n} = %s" % case $finishtype
    when "time"
      v * (t * ($finishpoint / cyc) + ($finishpoint % cyc < t ? $finishpoint % cyc : t))
    else
      "Unimplemented finish type #{$finishtype}"
    end
  end
end