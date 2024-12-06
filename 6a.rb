require 'set'

module Direction
  DIRECTIONS = %i[north east south west].freeze

  def self.next(current)
    index = DIRECTIONS.index(current)
    index = (index + 1) % DIRECTIONS.size
    DIRECTIONS[index]
  end
end

def solve()
  board = File.readlines('inputs/6', chomp: true)
  direction = :north 
  visited = Set.new

  # Find the start position
  row, col = board.each_with_index do |line, r|
    c = line.index('^')
    break [r, c] if c
  end

  loop do
    visited << [row, col]

    # Determine next position
    next_row, next_col = row, col
    case direction
    when :north then next_row -= 1
    when :east  then next_col += 1
    when :south then next_row += 1
    when :west  then next_col -= 1
    end

    # Break if out of bounds
    break if next_row < 0 || next_row >= board.size || next_col < 0 || next_col >= board[0].size

    if board[next_row][next_col] == '#'
      direction = Direction.next(direction)
    else
      row = next_row 
      col = next_col 
    end
  end

  visited.size
end

puts solve
