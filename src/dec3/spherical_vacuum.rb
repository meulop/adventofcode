require 'pp'

@santa_count = ARGV[0].to_i()

@santa_positions = @santa_count.times.map { [0,0] }
@nice = { "0-0" => 2 }
@nice.default = 0

File.open('data/dec3/input.txt').each_char.with_index do |c, idx|
  # Which Santa are we moving?
  @santa_id = idx % @santa_count
  case c
    when '^'
      @santa_positions[@santa_id][1] +=1
      @nice["#{@santa_positions[@santa_id][0]}-#{@santa_positions[@santa_id][1]}"] += 1
    when 'v'
      @santa_positions[@santa_id][1] -= 1
      @nice["#{@santa_positions[@santa_id][0]}-#{@santa_positions[@santa_id][1]}"] += 1
    when '<'
      @santa_positions[@santa_id][0] -= 1
      @nice["#{@santa_positions[@santa_id][0]}-#{@santa_positions[@santa_id][1]}"] += 1
    when '>'
      @santa_positions[@santa_id][0] +=1
      @nice["#{@santa_positions[@santa_id][0]}-#{@santa_positions[@santa_id][1]}"] += 1
    else
      puts "There are exits to the North, South, East and West"
  end
end


puts "Nice children: #{@nice.length()}"