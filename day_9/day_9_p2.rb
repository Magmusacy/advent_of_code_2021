inputs = File.open('day_9_inputs.txt', 'r').readlines.map do |line|
  line.strip.chars
end

def find_low_points(inputs)
  low_points = []
  inputs.each_with_index do |line, i|
    line.each_with_index do |char, j|
      adjacent_points = []
      adjacent_points << line.dig(j - 1) unless j - 1 < 0
      adjacent_points << inputs.dig(i - 1, j) unless i - 1 < 0

      adjacent_points += [ line.dig(j + 1),  inputs.dig(i + 1, j)].compact
      low_points << [i, j] if adjacent_points.all? { |point| point.to_i > char.to_i }
    end
  end

  low_points
end

def get_basin_sizes(inputs, all_low_points)
  sizes = []
  all_low_points.each do |low_point|
    low_point_val = (inputs[low_point[0]][low_point[1]]).to_i
    basin_size = bfs(inputs, low_point).length + low_point_val
    sizes << basin_size
  end

  sizes
end

# given low point COORDINATES
# add adjacent COORDINATES to the queue
# when checking current coordinate
# make sure that value in inputs array at that coordinate is not 9 or nil

def bfs(inputs, low_point)
  visited_points = []
  queue = [low_point]
  until queue.empty?
    point = queue.shift
    row, col = point
    next if inputs.dig(row, col) == "9" || inputs.dig(row, col).nil?
    visited_points << point
    adjacent_points = []
    adjacent_points << [row - 1, col] unless (row - 1 < 0)
    adjacent_points << [row, col - 1] unless (col - 1 < 0)
    adjacent_points << [row + 1, col]
    adjacent_points << [row, col + 1]
    queue.concat(adjacent_points - visited_points)
  end

  visited_points.uniq
end

p get_basin_sizes(inputs, find_low_points(inputs)).sort.last(3).reduce{|f,y| f*y}