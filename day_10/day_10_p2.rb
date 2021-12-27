OPENING_SYMBOLS = ["(", "[", "<", "{"]
CLOSING_SYMBOLS = [")", "]", ">", "}"]
OPEN_TO_CLOSE_MAP = { "(" => ")", "[" => "]", "<" => ">", "{" => "}" }

def complete_chunks(chars, closings_ary)
  return if chars.empty?
  opening = chars.first
  if OPENING_SYMBOLS.include?(opening)
    opening = chars.shift
    closing = complete_chunks(chars, closings_ary)
  elsif CLOSING_SYMBOLS.include?(opening)
    return opening
  end

  if closing.nil?
    closings_ary << OPEN_TO_CLOSE_MAP[opening]
    return
  elsif OPEN_TO_CLOSE_MAP[opening] == closing && ![closing, opening].include?(nil)
    idx = chars.index{|e| e.object_id == closing.object_id}
    chars.delete_at(idx)
    complete_chunks(chars, closings_ary)
  end
end

def traverse_chunks(chars, errors)
  return if chars.empty? # this takes care of incomplete lines
  opening = chars.first
  if OPENING_SYMBOLS.include?(opening)
    opening = chars.shift
    closing = traverse_chunks(chars, errors)
  elsif CLOSING_SYMBOLS.include?(opening)
    return opening
  end

  if OPEN_TO_CLOSE_MAP[opening] == closing
    idx = chars.index{|e| e.object_id == closing.object_id}
    chars.delete_at(idx)
    traverse_chunks(chars, errors)
  else
    errors << closing
    return
  end
end

def incomplete_lines(inputs)
  incomplete_lines = []
  inputs.each do |line|
    errors = []
    traverse_chunks(line.chars, errors)
    incomplete_lines << line if errors.first.nil?
  end

  incomplete_lines
end

def calculate_score(closings)
  completion_score =   {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
    }

  closings.reduce(0) do |total, closing|
    (total * 5) + completion_score[closing]
  end
end

def part_two
  inputs = File.open('day_10_inputs.txt', 'r').readlines.map(&:strip)
  scores = []
  incomplete_lines(inputs).map(&:chars).each do |line|
    closings = []
    complete_chunks(line, closings)
    scores << calculate_score(closings)
  end
  scores.sort[(scores.length/2)]
end

p part_two