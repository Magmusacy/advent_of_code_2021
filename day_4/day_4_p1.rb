# first line has numbers that will be chosen
# then there is \n
# then next five elements is first board
# each board is seperated by whitespace character

# ALGO:
# OPEN file day_3_inputs.txt
# inputs = file day_3_inputs.txt where each line is a different element in the array
# numbers_list = inputs[0]
# boards = array where each element represents 5x5 board from inputs
# winning_board = nil
# FOR each number from numbers_list
#   IF current board's rows and columns has a set of numbers that were drawn up until and including current number
#     also return already drawn nums ;D
#     winning_board = index of current board
#     RETURN from the loop
#   END IF
# END FOR
# calculate the sum of all numbers in winning board excluding drawn numbers that are present on that board
# after doing this check if adding map to row split would change execution time

# what if we drawn all the numbers in correct order, then checked which rows or columns win and tried to find which winning order own first, then substract
# the rest of numbers from array and calculate bruh
def any_rows?(multi_dimensional_ary, drawn_numbers)
  multi_dimensional_ary.each { |row| return true if (row & drawn_numbers) == row }

  nil
end

def any_columns?(multi_dimensional_ary, drawn_numbers)
  5.times do |i|
    column = []
    5.times do |j|
      column << multi_dimensional_ary[j][i]
    end
    return true if (column & drawn_numbers) == column
  end

  nil
end

def winning_board(hsh, drawn_numbers)
  hsh.each { |k, v| return k if any_rows?(v, drawn_numbers) || any_columns?(v, drawn_numbers) }

  nil
end

def part_one
  inputs = File.open('day_4_inputs.txt', 'r').readlines.map(&:strip)
  numbers_list = inputs[0]
  drawn_numbers = []
  i = 0
  boards = Hash.new { |h,k| h[k] = [] }
  boards = inputs[2..-1].reduce(boards) do |hsh, row|
    if row.empty?
      i += 1
    else
      hsh[i] << row.split(" ")
    end

    hsh
  end

  winning_board_num = nil

  numbers_list.split(",").each do |num|
    drawn_numbers << num
    winning_board_num = winning_board(boards, drawn_numbers)
    break unless winning_board_num.nil?
  end

  drawn_numbers.map!(&:to_i)
  numbers_on_board = boards[winning_board_num].flatten.map(&:to_i)
  marked_nums = numbers_on_board & drawn_numbers
  (numbers_on_board - marked_nums).sum * drawn_numbers.last
end

p part_one
