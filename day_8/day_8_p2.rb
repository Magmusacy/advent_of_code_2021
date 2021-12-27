def decipher_signals(signal_pattern)
  seg_to_sig = { a: nil, c: nil, b: nil, d: nil, f: nil, e: nil, g: nil }
  unique_digits = signal_pattern.select { |digit| [2, 4, 3].include?(digit.length) }

  right_segments = unique_digits[0] & unique_digits[1] & unique_digits[2]
  seg_to_sig[:a] = unique_digits.find { |digit| digit.length == 3 } - right_segments

  digit_3 = signal_pattern.find do |signal|
      signal.length == 5 && (seg_to_sig[:a] + right_segments).all? { |segment| signal.include?(segment) }
  end

  digit_4 = unique_digits.find { |d| d.length == 4 }

  middle = (digit_4 - right_segments) & digit_3
  seg_to_sig[:d] = middle
  seg_to_sig[:b] = (digit_4 - right_segments - middle)

  digit_5 = signal_pattern.find do |signal|
      signal.length == 5 && right_segments.one? { |segment| signal.include?(segment) } && seg_to_sig.values.flatten.compact.all? do |f|
      signal.include?(f)
    end
  end

  right_down = digit_5 & right_segments
  seg_to_sig[:f] = right_down
  seg_to_sig[:c] = right_segments - right_down
  seg_to_sig[:g] = digit_5 - seg_to_sig.values.flatten
  seg_to_sig[:e] = ("a".."g").to_a - seg_to_sig.values.flatten

  seg_to_sig
end

def part_two
  inputs = File.open('day_8_inputs.txt', 'r').readlines.map(&:strip)
  seg_to_dig = { 'abcefg' => '0', 'cf' => '1', 'acdeg' => '2', 'acdfg' => '3',
                 'bcdf' => '4', 'abdfg' => '5', 'abdefg' => '6',
                 'acf' => '7', 'abcdefg' => '8', 'abcdfg' => '9' }
  all_nums = 0
  inputs.each do |display|
    display = display.split(" | ")
    signal_pattern = display.first.split(" ").map { |signal| signal.chars }
    chuj = decipher_signals(signal_pattern)
    industry_abby = ""
    display.last.split(" ").each do |digit|
      sram = []
      digit.chars.each { |segment| sram << chuj.key([segment]).to_s }
      industry_abby << seg_to_dig[sram.sort.join]
    end
    all_nums += industry_abby.to_i
  end
  all_nums
end

p part_two