def solve
  # Read the stones and their counts from the input file
  stones = File
    .read('inputs/11', chomp: true)
    .split
    .map(&:to_i)
    .tally

  memoize = {}

  # Define a method to transform a single stone
  transform = lambda do |stone|
    return [1] if stone.zero?
    return [memoize[stone]] if memoize.key?(stone)

    str = stone.to_s
    if str.length.even?
      mid = str.length / 2
      result = [str[...mid].to_i, str[mid..].to_i]
      memoize[stone] = result
      result
    else
      result = stone * 2024
      memoize[stone] = result
      [result]
    end
  end

  # Define a method to apply the transformation to all stones
  blink = lambda do |stones|
    stones.each_with_object(Hash.new(0)) do |(stone, count), result|
      transform.call(stone).flatten.each { |t| result[t] += count }
    end
  end

  # Perform 75 transformations
  75.times { stones = blink.call(stones) }

  # Return the sum of all the stone counts
  stones.values.sum
end

puts solve
