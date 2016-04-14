# Wordy: LaunchSchool Weekly Ruby Challenge
# Completed: 4/14/2016
# About an hour
class WordProblem
  OPS = { 'plus' => '+',
          'minus' => '-',
          'multiplied by' => '*',
          'divided by' => '/' }.freeze

  def initialize(word_problem)
    @problem = word_problem
  end

  def answer
    maths = @problem.scan(/^(What is )(.*)(\?)$/).first[1]

    raise ArgumentError unless maths

    # Replace word operators to symbolic operator
    OPS.each do |word_operator, sym_operator|
      maths.gsub! word_operator, sym_operator
    end

    components = maths.split(' ')

    # Pattern: number operator number [operator number...]
    value = components.shift.to_i # First number
    until components.empty?
      operator = components.shift

      # Must be a recognized math operation
      raise ArgumentError unless OPS.values.include? operator

      number = components.shift.to_i
      # value = eval("#{value}#{operator}#{number}")
      value = value.send(operator, number)
    end
    value
  end
end
