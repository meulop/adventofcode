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
  
  # Cleverer bf
  x.report do
    a=1.upto(buckets.length).map do |i|
      buckets.combination(i).select do |b|
        b.reduce(:+)==150
      end.length
    end
    idx = a.index do |x|
      x > 0
    end
    pp a[idx]
  end
end