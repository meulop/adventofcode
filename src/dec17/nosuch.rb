require 'pp'
require 'optparse'
require 'benchmark'

buckets = []

params = ARGV.getopts("l:")

litres = params[:l]


File.open('data/dec17/input.txt').each do |line|
  buckets << line.chomp.to_i  
end

buckets.sort!

Benchmark.bm do |x|
  
  # Brute force!
  x.report do
    a=(2** buckets.length).times.select do |i|
      buckets.each_with_index.map do |b,j|
        ((i >> j) & 1) == 1 ? b : 0
      end.reduce(:+) == 150
    end.length
    pp a
  end

  # Cleverer bf
  x.report do
    a=1.upto(buckets.length).map do |i|
      buckets.combination(i).select do |b|
        b.reduce(:+)==150
      end.length
    end.reduce(:+)
    pp a
  end
end