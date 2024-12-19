def parse_input
  parsing = :patterns
  patterns = []
  designs = []

  File.readlines('inputs/19', chomp: true).each do |line|
    if line == ''
      parsing = :designs
      next
    end

    case parsing
    when :patterns
      patterns.concat(line.split(', '))
    when :designs
      designs << line
    end
  end

  [patterns, designs]
end

def solve
  patterns, designs = parse_input
  viable = Set.new 

  designs.each do |design|
    stack = [0]
    visited = Set.new

    found = false
    until stack.empty? || found
      position = stack.pop
      next if visited.include?(position)
      visited << position

      if position == design.size
        viable << design
        found = true
        break
      end

      patterns.each do |pattern|
        stack << position + pattern.size if design[position..-1].start_with?(pattern)
      end
    end
  end

  viable.size
end

p solve
