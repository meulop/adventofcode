require 'pp'

naughty_substrs = ["ab","cd","pq","xy"]
vowels = ["a","e","i","o","u"]


puts naughty_substrs.index { |ns| "ab".include?(ns) }
puts naughty_substrs.index { |ns| "pq".include?(ns) }
puts naughty_substrs.index { |ns| "ac".include?(ns) }




a=File.open('data/dec5/input.txt').select do |st|
  # Always naughty, so check this first
  if nil != naughty_substrs.index { |ns| st.include?(ns) }
    pp "#{st} " + naughty_substrs.index { |ns| st.include?(ns) }.to_s()
    false
  elsif st.count("aeiou") < 3
    pp "#{st} " + st.count("aeiou").to_s
    false
  elsif st.match(/(.)\1/)
    pp "#{st} " + st.match(/(.)\1/).to_s
    true
  else
    false
  end
end

pp a.length