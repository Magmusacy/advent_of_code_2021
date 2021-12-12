# ALGORITHM:
# you can supply oxygen or co2 bit criteria through blocks
# DEF METHOD count_bits(ary, bit_position)
#   bits_frequency = {"1" => 0, "0" => 0}
#   LOOP EACH ary ELEMENT WITH INDEX
#     IF INDEX == bit_position
#       bits_frequency[ELEMENT] =+ 1
#     END IF
#   END LOOP
#   RETURN bits_frequency
# END METHOD

# bits_criteria for oxygen rating
#   determine most common value (0 or 1 in the current bit position) and keep only correct bits (with most common bit in that pos)
#   if 0 and 1 are equally common keep 1
# bits_criteria for co2 scrubber
#   determine least common value in that bit position and if both are equally common keep 0 (i think it's the reverse of oxygenrating) or not cuz the last  bit differs

# DEF METHOD part_two
#   load day_3_inputs.txt and store each line of that file in an array
#   run method count_bits
#   discard elements from inputs_array that do not match bit criteria specified in block

def count_bits(ary, bit_position)
  bit_frequency = { "1" => 0, "0" => 0 }

  ary.each_with_index do |el, idx|
    bit = el[bit_position]
    bit_frequency[bit] += 1
  end

  bit_frequency
end

def part_two
  inputs_array = File.open('day_3_inputs.txt', 'r').readlines.map(&:strip)
  bit_count = inputs_array.first.length
  rating_pattern = ""

  (0...bit_count).each do |bit|
    break if inputs_array.length == 1
    bits_frequency = count_bits(inputs_array, bit)
    rating_pattern += yield(bits_frequency)

    inputs_array.select! { |bits| bits.start_with?(rating_pattern) }
  end

  inputs_array.first
end

y = part_two do |bits_frequency|
  case bits_frequency.values.first == bits_frequency.values.last
  when true then "1"
  else bits_frequency.key(bits_frequency.values.max)
  end
end

x = part_two do |bits_frequency|
  case bits_frequency.values.first == bits_frequency.values.last
  when true then "0"
  else bits_frequency.key(bits_frequency.values.min)
  end
end

p x.to_i(2) * y.to_i(2)