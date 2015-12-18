require 'pp'

wires = Hash.new do |h,k|
  # Cheat - treat a number as a wire that returns that number as input
  k.to_i
end


File.open('data/dec7/input.txt').each do |line|
  line.chomp.match(/((?<i1>[^ ]+) )??((?<op>[^ ]+) )?(?<i2>[^ ]+) -> (?<o1>[^ ]+)/) do |m|
    wires[m[:o1]] = case m[:op]
    when "AND"
      wires[m[:i1]] & wires[m[:i2]]
    when "OR"
      wires[m[:i1]] | wires[m[:i2]]
    when "LSHIFT" then
      wires[m[:i1]] << wires[m[:i2]]
    when "RSHIFT" then
      wires[m[:i1]] >> wires[m[:i2]]
    when "NOT" then
      65535 ^ wires[m[:i2]]
    when nil
      # No op - just assignment
      m[:i2].to_i
    else
      puts "Unknown operation #{m[:op]}"
      exit 1
    end
    puts "#{m[:o1]} = #{wires[m[:o1]]}"
  end

end


pp wires
puts wires["a"]