require 'pp'

@light_grid = 1000.times.map do 
  1000.times.map{ 0 }
end

puts @light_grid.length
puts @light_grid.flatten.length

File.open('data/dec6/input.txt').each do |line|
  line.match(/([a-z\ ]+)([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)$/) do |m|
    @instr = m[1]
    (@x0,@y0,@x1,@y1) = m[2,4].map {|x| x.to_i }
    @width = @x1+1-@x0
    @height = @y1+1-@y0
    if @instr == "turn on "
      (@x0..@x1).each {|x| (@y0..@y1).each { |y| @light_grid[x][y] += 1 } }
    elsif @instr == "turn off "
      (@x0..@x1).each {|x| (@y0..@y1).each { |y| @light_grid[x][y] = [0,(@light_grid[x][y] - 1)].max } }
    elsif @instr == "toggle "
      (@x0..@x1).each {|x| (@y0..@y1).each { |y| @light_grid[x][y] += 2 } }
    else
      puts "Invalid instruction #{m[:instr]}"
    end
  end

end

pp @light_grid.flatten.inject(:+)