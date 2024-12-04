require 'set'

$puzzle = File.readlines('inputs/4').map(&:chomp)
$rows = $puzzle.length
$cols = $puzzle[0].length
$word = "XMAS"
$directions = Set.new([
  [-1, -1], # Up-left
  [-1,  0], # Up
  [-1,  1], # Up-right
  [ 0, -1], # Left
  [ 0,  1], # Right
  [ 1, -1], # Down-left
  [ 1,  0], # Down
  [ 1,  1], # Down-right
])

def traverse(row, col, direction, index = 0)
  # Out of bounds
  return 0 if row < 0 or col < 0 or row >= $rows or col >= $cols

  # Found XMAS
  return 1 if index == $word.length - 1 && $puzzle[row][col] == $word[index]

  # Mismatch
  return 0 if $puzzle[row][col] != $word[index]

  # Continue traversing 
  return traverse(row + direction[0], col + direction[1], direction, index + 1)
end

sum = $puzzle.each_with_index.sum do |row, row_index|
  row.each_char.with_index.sum do |_, col_index|
    $directions.sum { |direction| traverse(row_index, col_index, direction) }
  end
end

puts sum
