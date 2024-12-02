def safe?(report)
  pairs = report.each_cons(2)
  return pairs.all? { |a, b| (a-b).between?(1, 3)} || pairs.all? { |a, b| (b-a).between?(1, 3) }
end

safe_reports = File.foreach('inputs/2').count do |report|
  report = report.split.map(&:to_i)
  report.each_index.any? { |i| safe?(report[0...i] + report[i+1..-1]) }
end

puts safe_reports 
