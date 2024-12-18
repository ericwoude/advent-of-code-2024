require 'set'

def solve(bytes, cols, rows)
  corrupt_bytes = File
    .readlines('inputs/18', chomp: true)
    .map { |line| line.split(',').map(&:to_i) }
    .take(bytes)

  start = [0, 0]
  target = [cols - 1, rows - 1]
  queue = [[start, 0]] # [[position, steps]]
  visited = Set.new([start])

  directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  until queue.empty?
    (current, steps) = queue.shift
    x, y = current

    return steps if [x, y] == target

    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy

      next if nx < 0 || nx >= cols || ny < 0 || ny >= rows
      next if visited.include?([nx, ny])
      next if corrupt_bytes.include?([ny, nx])

      visited.add([nx, ny])
      queue << [[nx, ny], steps + 1]
    end
  end

  nil
end

puts solve(1024, 71, 71)
