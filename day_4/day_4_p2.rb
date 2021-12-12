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
  winning_boards = []
  hsh.each { |k, v| winning_boards << k if any_rows?(v, drawn_numbers) || any_columns?(v, drawn_numbers) }
  return winning_boards unless winning_boards.nil?

  nil
end

def part_two
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

  won_boards = []
  boards_copy = boards.dup

  numbers_list.split(",").each do |num|
    drawn_numbers << num
    winning_board_nums = winning_board(boards_copy, drawn_numbers)

    if !winning_board_nums.nil?
      winning_board_nums.each do |board_num|
        unless won_boards.flatten.include?(board_num)
          won_boards << [board_num, drawn_numbers.dup] # dup here makes sure drawn_numbers array isn't mutated in next iterations
          boards_copy.delete(board_num)
        end
      end
    end
  end

  board_num = won_boards.last.first
  drawn_numbers = won_boards.last.last.map(&:to_i)
  won_board = boards[board_num].flatten.map(&:to_i)

  (won_board - drawn_numbers).sum * drawn_numbers.last
end

p part_two
