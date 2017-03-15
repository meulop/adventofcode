require 'pp'

actualsue = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

ops = Hash.new(:==)

ops[:cats] = ops[:trees]=:<
ops[:pomeranians] = ops[:goldfish] = :>


File.open("data/dec16/input.txt").each do |line|
  # Blindly accept our input is in the correct format
  # (Bad idea generally)
  line.chomp.match(/Sue (?<id>[0-9]+):(?<data>.*)/) do |m|
    sue = eval "{#{m[:data]} }"
    sue.delete_if do |k,v|
      [actualsue[k],v].reduce(ops[k])
    end
    sue.empty? and puts m[:id]
  end
end