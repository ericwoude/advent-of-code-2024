def parse_input
  boxes = Set.new
  walls = Set.new
  moves = []
  robot = nil
  rows = 0
  cols = 0
  current_section = :grid

  File.foreach('inputs/15', chomp: true).with_index do |line, i|
    if line.empty?
      current_section = :moves
      next
    end

    case current_section
    when :grid
      cols = line.size
      line.chars.each_with_index do |char, pos|
        case char
        when '@'
          robot = [i, pos]
        when 'O'
          boxes << [i, pos]
        when '#'
          walls << [i, pos]
        end
      end
      rows = i if line.match?(/\A#+\z/)
    when :moves
      moves.concat(line.chars)
    end
  end

  [walls, boxes, moves, robot, rows, cols]
end

def next_position((x, y), direction)
  case direction
  when '^' then [x - 1, y]
  when 'v' then [x + 1, y]
  when '<' then [x, y - 1]
  when '>' then [x, y + 1]
  end
end

def out_bounds?(row, col, rows, cols)
  row < 0 || row >= rows || col < 0 || col >= cols
end

def solve
  walls, boxes, moves, robot, rows, cols = parse_input

  moves.each do |move|
    next_pos = next_position(robot, move)
    next if out_bounds?(*next_pos, rows, cols) || walls.include?(next_pos)

    if boxes.include?(next_pos)
      # Find the last box in a sequence of boxes
      new_box_position = next_pos
      new_box_position = next_position(new_box_position, move) while boxes.include?(new_box_position)
      next if out_bounds?(*new_box_position, rows, cols) || walls.include?(new_box_position)

      # Remove first box in the sequence (the new robot position)
      # and add a box at the end of the sequence
      boxes.delete(next_pos)
      boxes << new_box_position 
    end

    robot = next_pos
  end

  # Calculate the sum of the Goods Positioning System
  boxes.sum { |x, y| 100 * x + y }
end

puts solve 
