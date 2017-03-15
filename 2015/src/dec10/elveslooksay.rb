require 'pp'
$reps = ARGV[0].to_i

if $reps <1
  puts "Reps must be integer > 0"
  exit 1
end

File.open('data/dec10/input.txt').each do |line|
  line.chomp!
  $reps.times do |i|
    puts "#{i} #{line.length}"
    line.gsub!(/(.)\1*/) do |m|
      "#{m.length}#{m[0]}"
    end
  end
  puts line.length
end