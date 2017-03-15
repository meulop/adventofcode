require 'pp'

@paper_area = 0
@ribbon_length = 0

File.open('data/dec2/input.txt').each do |dims|
  (l,w,h) = dims.chomp!().split("x").map(&:to_i).sort()
  @paper_area += (3 * l * w) + (2 * l * h) + (2 * w * h)
  @ribbon_length += 2 * (l + w) + (l * w * h)
end

puts "Wrapping paper = #{@paper_area} sqft"
puts "Ribbon = #{@ribbon_length} ft"
