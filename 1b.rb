locations = [] 
frequencies = Hash.new { |h, key| h[key] = 0 }

File.foreach('inputs/1') do |line|
  location, frequency = line.split.map(&:to_i)

  locations << location
  frequencies[frequency] += 1
end

puts locations.sum { |location| location * frequencies[location] }
