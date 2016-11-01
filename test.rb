def proposal_separate_line(big_string)
  big_string.gsub(/([\.\?!])( *)/, "\\1\n")
end
questions = File.readlines("#{__dir__}/data/questions.txt").map(&:chomp)
results = File.readlines("#{__dir__}/data/results.txt").map(&:chomp)

ANSWERS = [{ name: 'да', input: '1', score: 2 },
           { name: 'нет', input: '2', score: 0 },
           { name: 'иногда', input: '3', score: 1 }]

answers = ANSWERS.reduce('') { |a, n| "#{a} #{n[:input]} - #{n[:name]}\n" }

mark = 0
questions.each do |question|
  while true
    puts question
    puts answers
    answer = STDIN.gets.chomp
    break if ANSWERS.none? { |a| a[:input] == answer }
    puts "\nОтвет: не удалось распознать"
  end

  mark += ANSWERS.find { |a| a[:input] == answer }[:score]
end

puts "\nРезультаты теста: #{mark} баллов\n"
answer =
  case mark
  when (30..31)
    results[0]
  when (25..29)
    results[1]
  when (19..24)
    results[2]
  when (14..18)
    results[3]
  when (9..13)
    results[4]
  when (4..8)
    results[5]
  when (0..3)
    results[6]
  else
    results[7]
  end

puts proposal_separate_line(answer)
