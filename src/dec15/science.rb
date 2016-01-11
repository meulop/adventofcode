require 'pp'
require 'optparse'

$props = ["capacity","durability","flavor","texture","calories"]
$ings = []

class Ingredient
  $props.each do |p|
    attr_accessor p.to_sym
  end
 
  def initialize(name)
    @name=name
  end
end



OptionParser.new do |opts|
  $props.each do |a|
    opts.on("--[no-]#{a}","Include/exclude #{a} (default to include)") do |p|
      pp p
      p || props.delete(a)
    end
  end
end.parse!

File.open('data/dec15/input.txt').each do |line|
  line.chomp.match(/(?<name>[A-Za-z]+): (?<rest>.*)/) do |m1|
    i=Ingredient.new(m1[:name])
    m1[:rest].scan(/(?<prop>[a-z]+) (?<val>[-0-9]+)/) do |m2|
      pp m2
      i.send(m2[0] + '=',m2[1]) if $props.include?(m2[0])
    end
    $ings << i
  end
end

pp $ings

