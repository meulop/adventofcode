$pass = String.new(ARGV[0])

while $pass.next!
  next if $pass.sub!(/([ilo])(.*)/){ |m| $1.succ + "a"* $2.length }
  next unless $pass.match(/(.)\1.*((?!\1).)\2/)
  next unless $pass[0..5].chars.select.with_index do |c,i|
    $pass[i,3] == $pass[i] + $pass[i].succ + $pass[i].succ.succ
  end.length > 0
  break
end


puts $pass