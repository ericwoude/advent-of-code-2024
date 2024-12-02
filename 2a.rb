safe_reports = File.foreach('inputs/2').count do |report|
  pairs = report.split.map(&:to_i).each_cons(2)
  pairs.all? { |a, b| (a-b).between?(1, 3)} || pairs.all? { |a, b| (b-a).between?(1, 3) }
end

puts safe_reports 
