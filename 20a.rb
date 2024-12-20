def parse_input
  tiles = []
  start = nil
  destination = nil

  File.readlines('inputs/20', chomp: true).each_with_index do |line, row|
    line.chars.each_with_index do |char, col|
      start = [row, col] if char == 'S'
      destination = [row, col] if char == 'E'
      tiles << [row, col] if char != '#'
    end
  end

  [tiles, start, destination]
end

def find_path(tiles, start, destination)
  path = [start]
  current = start

  while current != destination
    path << current
    x, y = current

    # Find the next valid tile (only one option)
    current = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].find do |nx, ny|
      tiles.include?([nx, ny]) && !path.include?([nx, ny])
    end
  end

  path << destination
  path
end

def find_shortcuts(path)
  shortcuts = Hash.new(0)

  path.each_with_index do |(row, col), index|
    directions = [[2, 0], [-2, 0], [0, 2], [0, -2]]
    directions.each do |dx, dy|
      next_position = [row + dx, col + dy]
      next unless path.include?(next_position)

      next_index = path.index(next_position)
      if next_index && next_index > index
        shortcut_length = next_index - index - 2
        shortcuts[shortcut_length] += 1 if shortcut_length >= 100
      end
    end
  end

  shortcuts
end

tiles, start, destination = parse_input
path = find_path(tiles, start, destination)
shortcuts = find_shortcuts(path)

puts shortcuts.values.sum
