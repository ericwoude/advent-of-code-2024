def parse_input
  input = File.readlines('inputs/12', chomp: true)
  rows = input.size
  cols = input[0].size

  [input, rows, cols]
end

def bfs(graph, rows, cols, start, plant)
  queue = [start]
  visited = Set.new([start])

  until queue.empty?
    row, col = queue.shift

    neighbors = [[row - 1, col], [row + 1, col], [row, col - 1], [row, col + 1]]
    neighbors.each do |r, c|
      next if r < 0 || r >= rows || c < 0 || c >= cols
      next if visited.include?([r,c]) || graph[r][c] != plant

      visited.add([r,c])
      queue.push([r,c])
    end
  end

  visited
end

def borders(region)
  region.sum do |row, col|
    neighbors = [[row - 1, col], [row + 1, col], [row, col - 1], [row, col + 1]]
    neighbors.count { |neighbor| !region.include?(neighbor) }
  end
end


def solve
  garden, rows, cols = parse_input
  visited = Set.new
  groups = []

  garden.each_with_index do |line, r|
    line.chars.each_with_index do |char, c|
      next if visited.include?([r,c])

      group = bfs(garden, rows, cols, [r,c], char)
      groups << group unless group.empty?
      visited.merge(group)
    end
  end

  groups.sum { |group| borders(group) * group.size }
end

puts solve

