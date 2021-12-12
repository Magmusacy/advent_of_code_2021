# open file day_3_inputs.txt
# create an array where each element of the array represents each line from day_3_inputs.txt file
# n = length of first element in that array
# create array 'bits' of length n where every element is integer 0
# loop through each element from input_array
#   loop with index (i) through each character of each element of input_array
#     if current character == "0" then substract 1 from bits array at index (i)
#     if current character == "1" then add 1 to bits array at index (i)
#   convert bits array to represent binary digits.
#     if element < 0 then change it to "0"
#     if element > 0 then change it to "1"
#   join bits array to create a string named most_common_bits
#   create least_common_bits string that is opposite of most_common_bits, so everywhere where there is 1 in most_common_bits
#   in least_common_bits it must be 0 and vice versa
#   convert least_common_bits and most_common_bits to decimal and multiply

def part_one
  inputs_array = File.open('day_3_inputs.txt', 'r').readlines.map(&:strip)
  decimal_ary = Array.new(inputs_array[0].length, 0)

  inputs_array.each do |bits|
    bits = bits.chars
    bits.each_with_index do |bit, i|
      bit == "0" ? decimal_ary[i] -= 1 : decimal_ary[i] += 1
    end
  end

  most_common_bits = decimal_ary.map { |decimal| decimal < 0 ? "0" : "1" }
  least_common_bits = most_common_bits.map { |bit| bit == "0" ? "1" : "0" }

  most_common_bits.join("").to_i(2) * least_common_bits.join("").to_i(2)
end

p part_one