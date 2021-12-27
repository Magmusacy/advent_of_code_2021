def part_one
  inputs = File.open('day_8_inputs.txt', 'r').readlines.map(&:strip)

  unique_segment_numbers = 0

  inputs.each do |display|
    four_digits = display.split("|").last.split(" ")
    four_digits.each { |digit| unique_segment_numbers += 1 if [2, 4, 3, 7].include?(digit.length) }
  end

  unique_segment_numbers
end

p part_one