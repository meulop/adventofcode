
a=File.open('data/dec5/input.txt').select do |st|
  if !st.match(/(..).*\1/)
    false
  elsif !st.match(/(.)[^\1]\1/)
    false
  else
    true
  end
end

puts a