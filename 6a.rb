require 'set'

module Direction
  DIRECTIONS = %i[north east south west].freeze

  def self.next(current)
    index = DIRECTIONS.index(current)
    index = (index + 1) % DIRECTIONS.size
    DIRECTIONS[index]
  end
end

def next_position(pos, direction)
  row, col = pos
  case direction
  when :north then [row - 1, col]
  when :east  then [row, col + 1]
  when :south then [row + 1, col]
  when :west  then [row, col - 1]
  end
end

def parse_grid
  input = File.readlines('inputs/6', chomp: true)
  rows = input.size
  cols = input[0].size
  obstructions = []
  starting_position = nil

  input.each_with_index do |line, x|
    line.chars.each_with_index do |char, y|
      if char == '#'
        obstructions << [x, y]
      elsif char == '^'
        starting_position = [x, y]
      end
    end
  end

  [obstructions, rows, cols, starting_position]
end

def out_of_bounds?(pos, rows, cols)
  pos[0] < 0 || pos[0] >= rows || pos[1] < 0 || pos[1] >= cols
end

def solve
  obstructions, rows, cols, starting_position = parse_grid
  current = starting_position
  direction = :north
  visited = Set.new

  until out_of_bounds?(current, rows, cols)
    visited << current
    ahead = next_position(current, direction)

    if obstructions.include?(ahead)
      direction = Direction.next(direction)
    else
      current = ahead
    end
  end

  visited.size
end

puts solve
