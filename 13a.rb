require 'set'

def parse_input
  input = File.read('inputs/13', chomp: true)

  input.strip.split("\n\n").map do |game|
    lines = game.lines.map(&:strip)

    button_a = lines[0].match(/Button A: X\+(\d+), Y\+(\d+)/).captures.map(&:to_i)
    button_b = lines[1].match(/Button B: X\+(\d+), Y\+(\d+)/).captures.map(&:to_i)
    prize = lines[2].match(/Prize: X=(\d+), Y=(\d+)/).captures.map(&:to_i)

    [
      button_a[0],
      button_a[1],
      button_b[0],
      button_b[1],
      prize[0],
      prize[1],
    ]
  end
end

def solve
  games = parse_input
  visited = Set.new
  tokens = Set.new
  sum = 0

  walk = ->(x, y, ax, ay, bx, by, goal_x, goal_y, count_a, count_b, sum) do
    return if x > goal_x || y > goal_y
    return if count_a > 100 || count_b > 100
    return if visited.include?([count_a, count_b])

    visited << [count_a, count_b]

    return if 
    if x == goal_x && y == goal_y
      tokens << sum
      return
    end

    walk.call(x + ax, y + ay, ax, ay, bx, by, goal_x, goal_y, count_a + 1, count_b, sum + 3)
    walk.call(x + bx, y + by, ax, ay, bx, by, goal_x, goal_y, count_a, count_b + 1, sum + 1)
  end

  games.each do |game|
    walk.call(0, 0, *game, 0, 0, 0)
    sum += tokens.min unless tokens.empty?
    tokens = Set.new
    visited = Set.new
  end

  sum
end

puts solve
