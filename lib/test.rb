class Test
  ANSWERS = [{ name: 'да', input: '1', score: 2 },
             { name: 'нет', input: '2', score: 0 },
             { name: 'иногда', input: '3', score: 1 }]

  def self.proposal_separate_line(big_string)
    big_string.gsub(/([\.\?!])( *)/, "\\1\n")
  end

  def initialize
    @questions = File.readlines("#{__dir__}/../data/questions.txt").map(&:chomp)
    @results = File.readlines("#{__dir__}/../data/results.txt").map(&:chomp)

    @mark = 0
    @current_question_number = 0
    @questions_number = @questions.size
  end

  def answers
    @answers ||= ANSWERS.reduce('') { |a, n| "#{a} #{n[:input]} - #{n[:name]}\n" }
  end

  def result_string
    if test_passed?
      "Результаты теста: #{@mark} баллов. " +
      case @mark
      when (30..31) then @results[0]
      when (25..29) then @results[1]
      when (19..24) then @results[2]
      when (14..18) then @results[3]
      when (9..13) then  @results[4]
      when (4..8) then   @results[5]
      when (0..3) then   @results[6]
      else               @results[7]
      end
    end
  end

  def ask_question
    unless test_passed?()
      @questions[@current_question_number] + "\n" + answers
    end
  end

  def test_passed?
    @current_question_number >= @questions_number
  end

  def answer_admissible?(answer)
    unless test_passed?()
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
