require 'pp'

@light_grid = []


@light_grid = 1000.times.map do |x|
  1000.times.map{ |y| false }
end


pp @light_grid[3,2][1]

File.open('data/dec6/input.txt').each do |line|
  line.match(/([a-z\ ]+)([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)$/) do |m|
    @instr = m[1]
    (@x0,@y0,@x1,@y1) = m[2,4].map {|x| x.to_i }
    @width = @x1-@x0+1
    @height = @y1-@y0+1
    if @instr == "turn on "
      @light_grid[@x0,@width][@y0,@height] = @width.times.map{ |x| @height.times.map {|y| true} }
    elsif @instr == "turn off "
      @light_grid[@x0,@width][@y0,@height] = @width.times.map{ |x| @height.times.map {|y| false} }
    elsif @instr == "toggle "
      (@x0..@x1).each { |x| (@y0..@y1).each { |y| @light_grid[x][y] = !@light_grid[x][y] } }
    else
      puts "Invalid instruction #{m[:instr]}"
    end
  end
  puts @light_grid.flatten.select { |x| x }.length
end

puts @light_grid.flatten.select { |x| x }.length