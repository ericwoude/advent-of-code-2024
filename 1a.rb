left = []
right = []

File.foreach('inputs/1') do |line|
  a, b = line.split.map(&:to_i)

  left.insert(left.bsearch_index { |x| x >= a } || left.size, a)
  right.insert(right.bsearch_index { |x| x >= b } || right.size, b)
end

puts left.zip(right).sum { |a, b| (a - b).abs }
