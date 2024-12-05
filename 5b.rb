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

def find_broken_updates(rules, updates)
  updates.select do |update|
    update.each_with_index.any? do |current, i|
      update[i + 1..].any? { |number| rules[number].include?(current) }
    end
  end
end

def resolve_update(update, rules)
  solution = []
  remainder = update.clone

  until remainder.empty?
    i = remainder.find_index do |head|
      !remainder.any? { |number| rules[number].include?(head) }
    end

    if i
      solution << remainder.delete_at(i)
    else
      break # No way to solve
    end
  end

  solution
end

def solve
  rules, updates = parse_input
  broken_updates = find_broken_updates(rules, updates)

  broken_updates.sum do |update|
    solution = resolve_update(update, rules)
    solution[solution.size / 2] || 0 # Handle case if there is no solution
  end
end

puts solve
