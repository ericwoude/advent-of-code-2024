$puzzle = File.readlines('inputs/4').map(&:chomp)
$rows = $puzzle.length
$cols = $puzzle[0].length

def xmas?(row, col)
  # Out of bounds
  if row - 1 < 0 or row + 1 >= $rows or col - 1 < 0 or col + 1 >= $cols
    return false
  end

  # A possible x-mas cross
  if $puzzle[row][col] == "A"
    return (($puzzle[row-1][col-1] == "M" && $puzzle[row+1][col+1] == "S") || ($puzzle[row-1][col-1] == "S" && $puzzle[row+1][col+1] == "M")) &&
           (($puzzle[row+1][col-1] == "M" && $puzzle[row-1][col+1] == "S") || ($puzzle[row+1][col-1] == "S" && $puzzle[row-1][col+1] == "M"))
  end

  return false
end

count = $puzzle.each_with_index.sum do |row, row_index|
  row.each_char.with_index.count do |_, col_index|
    xmas?(row_index, col_index)
  end
end

puts count
