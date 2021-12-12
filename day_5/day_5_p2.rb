# consider only inputs where x1 = x2 or y1 = y2
# we need to count how many times do lines overlap
# for each line from inputs create an array that contains coordinates of every point of the line
# count how many times any given coordinate repeats
# output that count

def same_y_coords?(coords)
  coords[0][1] == coords[1][1]
end

def same_x_coords?(coords)
  coords[0][0] == coords[1][0]
end

def y_line(coords)
  line_coords = []
  line_ends = [coords[0][1].to_i, coords[1][1].to_i].sort
  (line_ends[0]..line_ends[1]).each do |y|
    line_coords << [coords[0][0], y.to_s]
  end

  line_coords
end

def x_line(coords)
  line_coords = []
  line_ends = [coords[0][0].to_i, coords[1][0].to_i].sort
  (line_ends[0]..line_ends[1]).each do |x|
    line_coords << [x.to_s, coords[0][1]]
  end

  line_coords
end

# since diagonal lines are at exactly 45 degrees we know that bots x and y increments by 1 at every step
def diagonal_line(coords)
  line_coords = []
  x_ends = [coords[0][0].to_i, coords[1][0].to_i]
  y_ends = [coords[0][1].to_i, coords[1][1].to_i]
  x_step = x_ends[1] <=> x_ends[0]
  y_step = y_ends[1] <=> y_ends[0]
  ((x_ends[0] - x_ends[1]).abs + 1).times do |i|
    line_coords << [(x_ends[0] + x_step * i).to_s, (y_ends[0] + y_step * i).to_s]
  end

  line_coords
end

def part_two
  inputs = File.open('day_5_inputs.txt', 'r').readlines.map do |el|
    el.gsub(/\s/, "").split("->").map { |xy| xy.split(",") }
  end

  hydrothermal_lines = []

  inputs.each do |coords|
    if same_x_coords?(coords)
      hydrothermal_lines += y_line(coords)
    elsif same_y_coords?(coords)
      hydrothermal_lines += x_line(coords)
    else
      hydrothermal_lines += diagonal_line(coords)
    end
  end

  overlappings = Hash.new { |hash, key| hash[key] = 0 }
  hydrothermal_lines.each do |l|
    overlappings[l] += 1
  end

  overlappings.values.select{|f| f > 1}.length
end

p part_two