DiskFragment = Struct.new(:id, :size, :tail)

fragments = File.read('inputs/9', chomp: true)
  .chars
  .each_slice(2)
  .with_index
  .map { |(size, tail), id| DiskFragment.new(id, size.to_i, tail.to_i) }

disk = []
while fragment = fragments.shift
  disk.push(*Array.new(fragment.size, fragment.id))

  while fragment.tail > 0 && !fragments.empty?
    last = fragments.last

    if last.size > 0
      disk << last.id
      fragment.tail -= 1
      last.size -= 1
    else
      fragments.pop
    end
  end
end

puts disk.each_with_index.sum { |id, index| id * index }
