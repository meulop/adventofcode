require 'pp'
$finishpoint=ARGV[0].to_i

$reindeer = []

class Reindeer

  attr_accessor :score
  attr_reader :position

  def initialize(name, speed, flytime, resttime)
    @name = name
    @speed = speed
    @flytime = flytime
    @resttime = resttime
    @score = 0
    @position = 0
    @state="flying"
    @flyingfor=0
    @restingfor=0
  end
  
  def move
    case @state
    when "flying"
      @position += @speed
      @flyingfor += 1
      if @flyingfor == @flytime
        @state = "resting"
        @restingfor = 0
      end
    when "resting"
      @restingfor += 1
      if @restingfor == @resttime
        @state = "flying"
        @flyingfor = 0
      end
    end
    @position
  end
end

File.open('data/dec14/input.txt').each do |line|
  line.chomp.match(/(?<n>\w+) can fly (?<v>\d+) km\/s for (?<t>\d+) seconds.*for (?<r>\d+) seconds/) do |m|
    n=m[:n]
    v=m[:v].to_i
    t=m[:t].to_i
    r=m[:r].to_i
    $reindeer << Reindeer.new(n,v,t,r)
  end
end

$finishpoint.times do
  maxpos = $reindeer.map{ |r| r.move }.max
  $reindeer.each{|r| r.position == maxpos && r.score += 1 }
end

pp $reindeer.max_by{ |r| r.score }