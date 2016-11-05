require_relative 'lib/test'

test = Test.new
loop do
  break if test.test_passed?
  question = test.ask_question
  loop do
    puts question
    answer = STDIN.gets.chomp
    break if test.answer_admissible?(answer)
    puts "Ответ: #{answer} не удалось распознать"
  end
end

puts Test.proposal_separate_line(test.result_string)
