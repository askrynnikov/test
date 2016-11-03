class Test
  ANSWERS = [{ name: 'да', input: '1', score: 2 },
             { name: 'нет', input: '2', score: 0 },
             { name: 'иногда', input: '3', score: 1 }]

  def self.proposal_separate_line(big_string)
    big_string.gsub(/([\.\?!])( *)/, "\\1\n")
  end

  def initialize
    @questions = File.readlines("#{__dir__}/data/questions.txt").map(&:chomp)
    @results = File.readlines("#{__dir__}/data/results.txt").map(&:chomp)

    @mark = 0
    @current_question_number = 0
    @questions_number = @questions.size
  end

  def answers
    @answers ||= ANSWERS.reduce('') { |a, n| "#{a} #{n[:input]} - #{n[:name]}\n" }
  end

  def print_results
    if @current_question_number < @questions_number
      'Тест не пройден.'
    else
      answer =
        case @mark
        when (30..31)
          @results[0]
        when (25..29)
          @results[1]
        when (19..24)
          @results[2]
        when (14..18)
          @results[3]
        when (9..13)
          @results[4]
        when (4..8)
          @results[5]
        when (0..3)
          @results[6]
        else
          @results[7]
        end
      "Результаты теста: #{@mark} баллов\n" + Test.proposal_separate_line(answer)
    end
  end

  def ask_question
    if @current_question_number < @questions_number
      @questions[@current_question_number] + "\n" + answers
    end
  end

  def get_answer(answer)
    if @current_question_number < @questions_number
      if ANSWERS.any? { |a| a[:input] == answer }
        @current_question_number += 1
        @mark += ANSWERS.find { |a| a[:input] == answer }[:score]
        true
      else
        false
      end
    end
  end
end
