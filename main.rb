require_relative 'test'

test = Test.new
loop do
  break if (question = test.ask_question).nil?

  loop do
    puts question
    answer = STDIN.gets.chomp
    break if test.get_answer(answer)
    puts "Ответ: #{answer} не удалось распознать"
  end
end
puts test.print_results