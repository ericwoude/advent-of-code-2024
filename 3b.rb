sum = 0
operating = true

File.foreach('inputs/3') do |line|
  i = 0

  until i >= line.length
    case line[i..]
    when /\Amul\((\d{1,3}),(\d{1,3})\)/  # Match mul(x,y)
      if operating
        sum += $1.to_i * $2.to_i
      end

      i += $&.length
    when /\Ado\(\)/  # Match do()
      operating = true
      i += 4
    when /\Adon't\(\)/  # Match don't()
      operating = false
      i += 7
    else
      i += 1
    end
  end
end

puts sum
