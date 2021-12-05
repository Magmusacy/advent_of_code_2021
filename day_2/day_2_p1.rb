# --- part one ---
# open day_2_inputs.txt file
# create an array where each input is seperate element
# horizontal = 0
# depth = 0
# start loop thorugh every element in the array
#   if element.include?('forward')
#     horizontal += extracted the number from string
#   if element.include?('up')
#     depth -= extracted the number from string
#   if element.include?('down')
#     depth += extracted the number from string

def part_one
  input_array = File.open('day_2_inputs.txt', 'r').readlines
  horizontal = 0
  depth = 0

  input_array.each do |el|
    extracted_num = el.gsub(/\D/, '').to_i
    extracted_direction = el.gsub(/\d/, "").strip.to_sym
    directions = { # I'm not sure why procs here work, but expression alone doesn't. I suspect it might be because expression evaluates when it's defined idk
                   up: Proc.new { depth -= extracted_num },
                   down: Proc.new { depth += extracted_num },
                   forward: Proc.new { horizontal += extracted_num }
                 }

    directions[extracted_direction].call
  end

  depth * horizontal
end

p part_one