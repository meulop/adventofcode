require 'digest'

def test_hash(input, threshold)
  Digest::MD5.hexdigest(input)[0,threshold] == ("0" * threshold)
end

i=1
input = File.open('data/dec4/input.txt').gets().chomp()


while !test_hash("#{input}#{i}",ARGV[0].to_i()) do
  i+=1
end

print "#{i} gives " + Digest::MD5.hexdigest("#{input}#{i}")