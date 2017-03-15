File.open('data/dec12/input.txt') do |f|
  puts f.read.split(/[^-\d]/).map { |x| x.to_i }.reduce(:+)
end