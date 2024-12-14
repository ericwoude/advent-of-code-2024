def solve
  grid_width = 101
  grid_height = 103
  steps = 100

  # Parse input
  positions = File.readlines('inputs/14', chomp: true).map do |line|
    px, py, vx, vy = line.scan(/-?\d+/).map(&:to_i)
    [(px + steps * vx) % grid_width, (py + steps * vy) % grid_height]
  end

  # Sort into quadrants
  mid_x = (grid_width / 2).to_i
  mid_y = (grid_height / 2).to_i
  quadrant_counts = positions.each_with_object(Hash.new(0)) do |(x, y), counts|
    quadrant = if x < mid_x
                 if y < mid_y
                   :left_up
                  elsif y > mid_y
                    :left_down
                  end
               elsif x > mid_x
                 if y < mid_y
                   :right_up
                  elsif y > mid_y
                    :right_down
                  end
               end
    counts[quadrant] += 1 if quadrant != nil
  end

  # Calculate safety factor
  quadrant_counts.values.reduce(1, :*)
end

puts solve
