class Test
  ANSWERS = [{ name: 'да', input: '1', score: 2 },
             { name: 'нет', input: '2', score: 0 },
             { name: 'иногда', input: '3', score: 1 }]

  def initialize
    @questions = File.readlines("#{__dir__}/../data/questions.txt").map(&:chomp)
    @results = File.readlines("#{__dir__}/../data/results.txt").map(&:chomp)

    @scores = 0
    @current_question_number = 0
    @questions_number = @questions.size
  end

  def answers
    @answers ||= ANSWERS.reduce('') { |a, n| "#{a} #{n[:input]} - #{n[:name]}\n" }
  end

  def result_string
    if passed?
      "Результаты теста: #{@scores} баллов. " +
      case @scores
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

  def current_question_and_answers
    unless passed?
      @questions[@current_question_number] + "\n" + answers
    end
  end

  def passed?
    @current_question_number >= @questions_number
  end

  def answer_scoring(answer)
    @scores += ANSWERS.find { |a| a[:input] == answer }[:score]
  end

  def next_question
    @current_question_number += 1
  end

  def answer_admissible?(answer)
    return false if passed?
    ANSWERS.any? { |a| a[:input] == answer }
  end
end
