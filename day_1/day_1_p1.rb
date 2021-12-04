# --- part one ---
# read input file
# create an array from input where each element represents each line from input file
# convert elements in array to integers
# larger_measurements = 0
# for each el in array
#   if el index == 0
#     next
#   if el index != 0
#     if el is > than previous el
#       larger_measurments += 1
#     else
#       next

def part_one
  input_array = File.open("day_1_inputs.txt", "r").readlines.map(&:to_i)
  larger_measurements = 0
  input_array.each_with_index do |el, idx|
    next if idx == 0

    if el > input_array[idx-1]
      larger_measurements += 1
    end
  end

  larger_measurements
end

part_one
