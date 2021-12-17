def part_one
  inputs = File.open('day_7_inputs.txt', 'r').readline.split(",").map{ |pos| pos.to_i}

  positions_and_fuel = Hash.new { |hash, key| hash[key] = 0 }

  inputs.uniq.each do |x_pos|
    inputs.each { |submarine| positions_and_fuel[x_pos] += (submarine - x_pos).abs }
  end

  positions_and_fuel.values.min
end

p part_one