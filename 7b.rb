def solve
  def traverse(sum, remainders, result)
    return true if sum == result
    return false if sum > result || remainders.empty?

    first, *rest = remainders
    traverse(sum + first, rest, result) ||
    traverse(sum * first, rest, result) ||
    traverse((sum.to_s + first.to_s).to_i, rest, result)
  end

  File.readlines('inputs/7').sum do |line|
    result_str, numbers_str = line.split(':')
    result = result_str.strip.to_i
    sum, *remainder = numbers_str.strip.split.map(&:to_i)

    traverse(sum, remainder, result) ? result : 0
  end
end

puts solve
