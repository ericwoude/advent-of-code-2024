require 'set'

def parse_input
  map = {}
  peaks = Set.new
  trailheads = Set.new

  input = File.readlines('inputs/10', chomp: true)
  rows = input.length
  cols = input[0].length

  input.each_with_index do |line, row|
    line.strip.chars.each_with_index do |char, col|
      height = char.to_i
      map[[row,col]] = height

      peaks << [row,col] if height == 9
      trailheads << [row,col] if height == 0
    end
  end

  [map, rows, cols, peaks, trailheads]
end

def out_of_bounds?(row, col, rows, cols)
  row < 0 || row >= rows || col < 0 || col >= cols
end

def solve
  map, rows, cols, peaks, trailheads = parse_input
  solution = Hash.new { |hash, key| hash[key] = 0 }

  traverse = ->(row, col, prev_value) do
    return if out_of_bounds?(row, col, rows, cols)

    if map[[row,col]] == prev_value - 1
      solution[[row,col]] += 1

      traverse.call(row - 1, col, prev_value - 1)
      traverse.call(row + 1, col, prev_value - 1)
      traverse.call(row, col + 1, prev_value - 1)
      traverse.call(row, col - 1, prev_value - 1)
    end
  end

  # Call traverse for each peak
  peaks.each { |pos| traverse.call(*pos, 9 + 1) }

  # Sum the amount of ways to get to the peak
  trailheads.sum { |trailhead| solution[trailhead] }
end

puts solve