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

def solve
  frequency, rows, cols = parse_input
  antinodes = Set.new

  frequency.each_value do |pairs|
    pairs.combination(2) do |(x1, y1), (x2, y2) |
      (0...rows).each do |x3|
        (0...cols).each do |y3|
          # Determinant check for collinearity
          antinodes << [x3, y3] if x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2) == 0
        end
      end
    end
  end

  antinodes.size
end

puts solve
