OPENING_SYMBOLS = ["(", "[", "<", "{"]
CLOSING_SYMBOLS = [")", "]", ">", "}"]
OPEN_TO_CLOSE_MAP = { "(" => ")", "[" => "]", "<" => ">", "{" => "}" }

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

def part_one
  inputs = File.open('day_10_inputs.txt', 'r').readlines.map(&:strip)
  error_endings = []
  inputs.each do |line|
    errors = []
    traverse_chunks(line.chars, errors)
    error_endings << errors.first unless errors.first.nil?
  end

  error_score =   {
                  ')' => 3,
                  ']' => 57,
                  '}' => 1197,
                  '>' => 25137
                  }
  error_endings.reduce(0) { |sum, el| sum += error_score[el] }
end

p part_one