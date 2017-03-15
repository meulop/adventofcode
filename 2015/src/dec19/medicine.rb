require 'pp'
require 'optparse'
require_relative '../adventure'

def replace(initial,mapping)
	ret=[]
	mapping.each do |k,v|
		kindex = initial.index(k)
		while kindex != nil do
			v.each do |v2|
				ret << case kindex
				when 0
					v2 + initial[kindex + k.length..initial.length]
				when initial.length-k.length
					initial[0..kindex-1] + v2
				else
					initial[0..kindex-1] + v2 + initial[kindex + k.length..initial.length]
				end
			end
			kindex = initial.index(k,kindex+1)
		end
	end
	ret.uniq.select {|x| x != nil }
end

a = Adventure.new('data/dec19/input.txt') do |options|
  OptionParser.new do |opts|
    opts.on("-I", "Iterations") do |i|
      options[:iterations] = i.to_i
    end
  end.parse!
end


a.process_input do |line, data|
  data[:mappings] ||= {}
  if m = line.match(/^(?<from>[A-Za-z]+) => (?<to>[A-Za-z]+)$/)
    data[:mappings][m[:from]] ||= []
    data[:mappings][m[:from]] << m[:to]
  else
    line.empty? or data[:initial] = line
  end
end



a.post_process do |data|
	pp "Function Length: " + replace(data[:initial],data[:mappings]).length.to_s
end