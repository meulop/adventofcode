@floor=0
@basement_step=-1
File.open('data/dec1/input.txt').each_char.with_index do |c, idx|
  @floor+=1 if c == '('
  @floor-=1 if c == ')'
  if (@basement_step == -1 and @floor == -1)
    @basement_step = idx + 1
  end
end

puts "Final floor: #{@floor}"
puts "Basement step: #{@basement_step}"
