# --- part two ---
# read input file
# create an array from input where each element represents each line from input file
# convert elements in array to integers
# larger_measurments = 0
# loop through input_array
#   if 3 next elements aren't nil
#     a_win = current element + 2 next elements
#     b_win = next_element + 2 elements after next_element
#       if b_win > a_win
#         larger_measurments += 1

def part_two
  input_array = File.open("day_1_inputs.txt", "r").readlines.map(&:to_i)
  larger_measurements = 0
  input_array.each_with_index do |el, idx|
    unless input_array[idx + 3].nil?
      a_win = el + input_array[idx + 1] + input_array[idx + 2] # this isn't the most beautiful way to do this, I might need to think how to make this cleaner
      b_win =  input_array[idx + 1] + input_array[idx + 2] + input_array[idx + 3]
      larger_measurements += 1 if b_win > a_win
    end
  end

  larger_measurements
end

p part_two
