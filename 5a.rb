require 'set'

def parse_input()
  rules = Hash.new { |hash, key | hash[key] = Set.new }
  updates = []
  current_section = :rules

  File.foreach('inputs/5', chomp: true) do |line|
    if line.empty?
      current_section = :updates
      next
    end

    case current_section
    when :rules
      before, after = line.split('|').map(&:to_i)
      rules[before] << after
    when :updates
      updates << line.split(',').map(&:to_i)
    end
  end

  [rules, updates]
end

def solve()
  rules, updates = parse_input()
  updates.sum do |update|
    violation = (0...update.size - 1).any? do |i|
      update[i + 1..].any? { |number| rules[number].include?(update[i]) }
    end

    violation ? 0 : update[update.size / 2]
  end
end

puts solve()
