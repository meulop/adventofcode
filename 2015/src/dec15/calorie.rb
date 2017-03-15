require 'pp'
require 'optparse'

$props = ["calories","capacity","durability","flavor","texture"]
$ings = []
$ing_names = []


class Ingredient
  $props.each do |p|
    attr_accessor p.to_sym
  end
  attr_accessor :name
  def initialize(name)
    @name=name
  end
end

def ingredient_score(recipe)
  totscore = $props.map do |p|
    score = $ings.map do |i|
      recipe[i.name] * i.send(p)
    end.reduce(:+)
    if p == "calories"
      (score == 500) ? 1 : 0
    else
      score > 0 ? score : 0
    end
  end
  totscore.include?(0) ? 0 : totscore.reduce(:*)
end

def combos(total,parts)
  case parts
  when 1
    [total]
  when 2
    (1..total-1).map do |i|
      [i,total -i]
    end
  else
    (1..total-1).map do |i|
      combos(total-i,parts-1).each do |a|
        (a << i)
      end
    end.flatten(1)
  end
end

OptionParser.new do |opts|
  $props.each do |a|
    opts.on("--[no-]#{a}","Include/exclude #{a} (default to include)") do |p|
      p || $props.delete(a)
    end
  end
end.parse!

File.open('data/dec15/input.txt').each do |line|
  line.chomp.match(/(?<name>[A-Za-z]+): (?<rest>.*)/) do |m1|
    i=Ingredient.new(m1[:name])
    m1[:rest].scan(/(?<prop>[a-z]+) (?<val>[-0-9]+)/) do |m2|
      i.send(m2[0] + '=',m2[1].to_i) if $props.include?(m2[0])
    end
    $ings << i
    $ing_names << i.name
  end
end

a=combos(100,$ings.length).map do |combo|
  ingredient_score(Hash[$ing_names.zip(combo)])
end

puts a.max