# Got to do this properly now?
require 'json'



def mccarthy(inobj)
  begin
    inobj.to_i
  rescue NoMethodError
    if inobj.kind_of? Array
      inobj.map{ |e| mccarthy(e)}.reduce(:+)
    elsif inobj.kind_of? Hash
      if inobj.has_value?("red")
        0
      else
        inobj.collect do |k,v|
          mccarthy(k) + mccarthy(v)
        end.reduce(:+)
      end
    end
  end
end

accounts = JSON.load(File.open('data/dec12/input.txt'))

puts mccarthy(accounts)

