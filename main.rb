require_relative 'lib/test'

def separate_line(string)
  string.gsub(/([\.\?!])( *)/, "\\1\n")
end

test = Test.new
until test.passed?
  answer = nil
  loop do
    puts test.current_question_and_answers
    answer = STDIN.gets.chomp
    break if test.answer_admissible?(answer)
    puts "Ответ: #{answer} не удалось распознать."
  end
  test.answer_scoring(answer)
  test.next_question
end

puts separate_line(test.result_string)





