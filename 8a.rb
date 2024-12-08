require 'set'

def parse_input
  frequency = Hash.new { |h, key| h[key] = [] }

  input = File.readlines('inputs/8', chomp: true)
  rows = input.size
  cols = input[0].size

  input.each_with_index do |line, row|
    line.each_char.with_index do |char, col|
      if char != '.'
        frequency[char] << [row, col]
      end
    end
  end

  [frequency, rows, cols]
end

def out_of_bounds?(position, rows, cols)
  position[0] < 0 || position[0] >= rows || position[1] < 0 || position[1] >= cols
end

def solve 
  frequency, rows, cols = parse_input
  antinodes = Set.new

  frequency.each_pair do |key, pairs|
    pairs.combination(2) do |(x1, y1), (x2, y2) |
      dx = x2 - x1
      dy = y2 - y1

      antinode_a = [x1 - dx, y1 - dy]
      antinode_b = [x2 + dx, y2 + dy]

      antinodes << antinode_a unless out_of_bounds?(antinode_a, rows, cols)
      antinodes << antinode_b unless out_of_bounds?(antinode_b, rows, cols)
    end
  end

  antinodes.size
end

puts solve
