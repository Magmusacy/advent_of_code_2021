# --- part two ---
# open day_2_inputs.txt file
# create an array where each input is seperate element
# horizontal = 0
# depth = 0
# aim = 0
# start loop thorugh every element in the array
#   ext_num = extracted number from string
#   if element.include?('forward')
#     horizontal += ext_num
#     depth += aim * ext_num
#   if element.include?('up')
#     aim -= ext_num
#   if element.include?('down')
#     aim += ext_num

def part_two
  input_array = File.open('day_2_inputs.txt', 'r').readlines
  horizontal = 0
  depth = 0
  aim = 0

  input_array.each do |el|
    ext_num = el.gsub(/\D/, '').to_i
    ext_direction = el.gsub(/\d/, "").strip.to_sym
    directions = {
                   up: Proc.new { aim -= ext_num },
                   down: Proc.new { aim += ext_num },
                   forward: Proc.new do
                     horizontal += ext_num
                     depth += aim * ext_num
                   end
                 }

    directions[ext_direction].call
  end

  depth * horizontal
end

p part_two