require 'set'

module Direction
  DIRECTIONS = %i[north east south west].freeze

  def self.next(current)
    index = DIRECTIONS.index(current)
    index = (index + 1) % DIRECTIONS.size
    DIRECTIONS[index]
  end
end

def next_position(row, col, direction)
  case direction
  when :north then [row - 1, col]
  when :east  then [row, col + 1]
  when :south then [row + 1, col]
  when :west  then [row, col - 1]
  end
end

def out?(row, col, rows, cols)
    row < 0 || row >= rows || col < 0 || col >= cols
end

def solve()
  board = File.readlines('inputs/6', chomp: true)
  direction = :north 
  visited = Set.new
  obstructions = []
  loops = 0

  # Find the start position
  row, col = board.each_with_index do |line, r|
    c = line.index('^')
    break [r, c] if c
  end

  loop do
    next_row, next_col = next_position(row, col, direction)
    break if out?(next_row, next_col, board.size, board[0].size)

    # Find a hypothetical loop
    # Take the last three obstructions
    # Then by placing a new obstruction, see if we can create a
    # square with the last three.
    # if so, count it

    if board[next_row][next_col] == '#'
      direction = Direction.next(direction)
      obstructions << [next_row, next_col]
    else
      row = next_row
      col = next_col
    end
  end

   p obstructions
  puts obstructions.size
end

solve
