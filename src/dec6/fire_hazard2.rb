require 'pp'

@light_grid = []


@light_grid = 1000.times.map do |x|
  1000.times.map{ |y| false }
end


File.open('data/dec6/input.txt').each do |line|
  line.match(/([a-z\ ]+)([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)$/) do |m|
    @instr = m[1]
    (@x0,@y0,@x1,@y1) = m[2,4].map {|x| x.to_i }
    @width = @x1+1-@x0
    @height = @y1+1-@y0
    puts "#{@width} #{@height}"
    if @instr == "turn on "
      @light_grid[@x0..@x1].each {|row| row[@y0..@y1] = @height.times.map { true } }
    elsif @instr == "turn off "
      @light_grid[@x0..@x1].each {|row| row[@y0..@y1] = @height.times.map { false } }
    elsif @instr == "toggle "
      (@x0..@x1).each { |x| (@y0..@y1).each { |y| @light_grid[x][y] = !@light_grid[x][y] } }
    else
      puts "Invalid instruction #{m[:instr]}"
    end
  end
  @light_grid.each.with_index do |slice, idx|
    puts "#{idx} #{slice.length}" if slice.length < 1000
  end
  puts @light_grid.flatten.select { |x| x }.length
  puts @light_grid.flatten.length
end

puts @light_grid.flatten.select { |x| x }.length