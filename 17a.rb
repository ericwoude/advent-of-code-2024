def parse_input
  a = nil
  b = nil
  c = nil
  program = []

  File.readlines('inputs/17', chomp: true).each do |line|
    case line
    when /Register A: (\d+)/
      a = $1.to_i
    when /Register B: (\d+)/
      b = $1.to_i
    when /Register C: (\d+)/
      c = $1.to_i
    when /Program: ([\d,]+)/
      program = $1.split(',').map(&:to_i)
    end
  end

  [a, b, c, program]
end

def execute
  a, b, c, program = parse_input
  pc = 0
  output = []

  combo = ->(operand) do
    case operand
    when 0, 1, 2, 3 then operand
    when 4 then a
    when 5 then b
    when 6 then c
    else raise 'Invalid combo operand'
    end
  end

  loop do
    break if pc >= program.size

    opcode, operand = program[pc..pc+1]

    case opcode
    when 0  # adv
      a = (a / (2**combo.call(operand))).to_i
    when 1  # bxl
      b ^= operand
    when 2  # bst
      b = combo.call(operand) % 8
    when 3  # jnz
      if a != 0
        pc = operand
        next
      end
    when 4  # bxc
      b ^= c
    when 5  # out
      output << (combo.call(operand) % 8)
    when 6  # bdv
      b = (a / (2**combo.call(operand))).to_i
    when 7  # cdv
      c = (a / (2**combo.call(operand))).to_i
    end

    pc += 2
 end

  puts "Register A: #{a}"
  puts "Register B: #{b}"
  puts "Register C: #{c}"
  puts "Output: #{output.join(',')}"
end

execute
