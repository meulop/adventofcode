require 'pp'

# Cache - effectively pre-populate with integers
$values = Hash.new do |h,k|
  k.to_i
end

$parents = Hash.new()

File.open('data/dec7/input.txt').each do |line|
  (inwire,outwire) = line.chomp.split(' -> ')
  $parents[outwire] = inwire.split      
end


def value(wire)
  if $values[wire] > 0 or wire == "0"
    $values[wire]
  else
    inputs = $parents[wire]
    case inputs.length
    when 1
      # Assignment x -> y
      $values[wire] = value(inputs[0])
    when 2
      # NOT x -> Y
      (inputs[0] == "NOT") or die("Unknown op")
      $values[wire] = 65535 ^ value(inputs[1])
    when 3
      (in1,op,in2) = inputs
      case op
      when 'AND'
        $values[wire] = value(in1).to_i & value(in2)
      when 'OR'
        $values[wire] = value(in1) | value(in2)
      when 'LSHIFT'
        $values[wire] = value(in1) << value(in2)
      when 'RSHIFT'
        $values[wire] = value(in1) >> value(in2)
      else
        die("Unknown Operation #{op}")
      end
    end
  end
end

pp value('a')