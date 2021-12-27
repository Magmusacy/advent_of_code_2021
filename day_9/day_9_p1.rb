inputs = File.open('day_9_inputs.txt', 'r').readlines.map do |line|
  line.strip.chars
end
sum = 0
inputs.each_with_index do |line, i|
  line.each_with_index do |char, j|
    adjacent_points = []
    adjacent_points << line.dig(j - 1) unless j - 1 < 0
    adjacent_points << inputs.dig(i - 1, j) unless i - 1 < 0

    adjacent_points += [ line.dig(j + 1),  inputs.dig(i + 1, j)].compact
    sum += (1 + char.to_i) if adjacent_points.all? { |point| point.to_i > char.to_i }
  end
end

p sum