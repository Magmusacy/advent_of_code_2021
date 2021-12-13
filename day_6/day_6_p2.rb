# NOTE: storing just the number of fishes with their cycle as a hashmap is much much faster than using array where each fish is represented as different element
def next_day(hsh)
  hsh.dup.each do |k,v|
    next if v.zero?

    if k.zero?
      hsh[8] += v
      hsh[0] -= v
      hsh[6] += v
    else
      hsh[k] -= v
      hsh[k - 1] += v
    end
  end
end

def part_one
  lantern_fishes = File.open('day_6_inputs.txt', 'r').readline.split(",").map(&:to_i)
  timer_hash = { 0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0 }
  lantern_fishes.each { |fish| timer_hash[fish] += 1 }
  256.times do |i|
    next_day(timer_hash)
  end

timer_hash
end

p part_one.values.sum