require 'pp'
require 'optparse'

$LOAD_PATH << File.dirname(__FILE__)

require_relative '../adventure'

$stuck = [[0,0],[0,99],[99,0],[99,99]]

def neighbours(grid,x,y)
  x0 = [x-1,0].max
  x1 = [x+1,grid.length-1].min
  y0 = [y-1,0].max
  y1 = [y+1,grid.length-1].min
  grid[x0..x1].map {|r| r[y0..y1] }.flatten.reduce(:+) - grid[x][y]
end

a = Adventure.new('data/dec18/input.txt') do |options|
  OptionParser.new do |opts|
    opts.on("-d", "Debug") do |d|
      options[:debug] = d
    end
  end.parse!
end

a.process_input do |line, data|
  data[:grid] ||= []
  data[:grid] << line.tr('.#','01').split("").map(&:to_i)
end

a.post_process do |data|
  100.times do
    new_grid = data[:grid].map.with_index do |row,i|
      row.map.with_index do |cell,j|
        if $stuck.index([i,j])
          1
        else
          n=neighbours(data[:grid],i,j)
          case n
          when 2
            cell
          when 3
            1
          else
            0
          end
        end
      end
    end
    data[:grid] = new_grid
  end
  puts data[:grid].flatten.reduce(:+)
end

