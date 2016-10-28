def proposal_separate_line(big_string)
  big_string.gsub(/([\.\?!])( *)/, "\\1\n")
end

questions = File.readlines("#{__dir__}/data/questions.txt").map(&:chomp)
results = File.readlines("#{__dir__}/data/results.txt").map(&:chomp)

answers = "1 - да\n2 - нет\n3 - иногда"
mark = 0
questions.each do |item|
  answer = nil
  loop do
    puts item
    puts answers
    answer = STDIN.gets.to_i
    break if [1, 2, 3].include?(answer)
    puts "\nОтвет: не удалось распознать"
  end

  case answer
    when 1 #да
      mark += 2
    when 2 #нет
      mark += 0
    when 3 #иногда
      mark += 1
  end
end

puts "\nРезультаты теста: #{mark} баллов\n"
answer =
    case mark
      when (30..31) then
        results[0]
      when (25..29) then
        results[1]
      when (19..24) then
        results[2]
      when (14..18) then
        results[3]
      when (9..13) then
        results[4]
      when (4..8) then
        results[5]
      when (0..3) then
        results[6]
      else
        results[7]
    end
puts proposal_separate_line(answer)
