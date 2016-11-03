class Test
  attr_reader :current_question, :number_questions, :mark

  ANSWERS = [{ name: 'да', input: '1', score: 2 },
             { name: 'нет', input: '2', score: 0 },
             { name: 'иногда', input: '3', score: 1 }]

  def self.proposal_separate_line(big_string)
    big_string.gsub(/([\.\?!])( *)/, "\\1\n")
  end

  def initialize
    @questions = File.readlines("#{__dir__}/data/questions.txt").map(&:chomp)
    @answers = ANSWERS.reduce('') { |a, n| "#{a} #{n[:input]} - #{n[:name]}\n" }
    @results = File.readlines("#{__dir__}/data/results.txt").map(&:chomp)

    @mark = 0
    @number_current_question = 0
    @number_questions = @questions.size
  end

  def run
    while @number_current_question < @number_questions
      ask_question
    end
    print_results
  end

  def print_results
    if @number_current_question < @number_questions
      puts "\nТеста не пройден."
    else
      puts "\nРезультаты теста: #{@mark} баллов\n"
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

      puts Test.proposal_separate_line(answer)
    end
  end

  private

  def ask_question
    while true
      puts @questions[@number_current_question]
      puts @answers
      answer = STDIN.gets.chomp
      break if ANSWERS.any? { |a| a[:input] == answer }
      puts "Ответ: #{answer} не удалось распознать"
    end

    @number_current_question += 1
    @mark += ANSWERS.find { |a| a[:input] == answer }[:score]
  end
end







