naughty_substrs = ["ab","cd","pq","xy"]


a=File.open('data/dec5/input.txt').select do |st|
  # Always naughty, so check this first
  if nil != naughty_substrs.index { |ns| st.include?(ns) }
    false
  elsif st.count("aeiou") < 3
    false
  elsif st.match(/(.)\1/)
    true
  else
    false
  end
end

puts a.length