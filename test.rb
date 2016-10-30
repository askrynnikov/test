def proposal_separate_line(big_string)
  big_string.gsub(/([\.\?!])( *)/, "\\1\n")
end

questions = File.readlines("#{__dir__}/data/questions.txt").map(&:chomp)
results = File.readlines("#{__dir__}/data/results.txt").map(&:chomp)

answers = "1 - да\n2 - нет\n3 - иногда"
mark = 0
questions.each do |question|
  while true
    puts question
    puts answers
    answer = STDIN.gets.to_i
    break if [1, 2, 3].include?(answer)
    puts "\nОтвет: не удалось распознать"
  end

  mark +=
    case answer
    when 1
      2 #да
    when 2
      0 #нет
    when 3
      1 #иногда
    end
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
