def calculate_arithemtic_progression(horizontal_move)
  (1 + horizontal_move) / 2.0 * horizontal_move
end

def part_two
  inputs = File.open('day_7_inputs.txt', 'r').readline.split(",").map{ |pos| pos.to_i}

  positions_and_fuel = Hash.new { |hash, key| hash[key] = 0 }

  inputs.uniq.each do |x_pos|
    inputs.each { |submarine| positions_and_fuel[x_pos] += calculate_arithemtic_progression((submarine - x_pos).abs) }
  end

  positions_and_fuel.values.min.to_i
end

p part_two