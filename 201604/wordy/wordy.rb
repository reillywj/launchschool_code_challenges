
class WordProblem
  OPS = { 'plus' => '+', 'minus' => '-', 'multiplied by' => '*', 'divided by' => '/'}

  def initialize(word_problem)
    @problem = word_problem
  end

  def answer
    _, maths, _ = @problem.scan(/^(What is )(.*)(\?)$/).first

    raise ArgumentError unless maths

    # Replace word operators to symbolic operator
    OPS.each do |word_operator, sym_operator|
      maths.gsub! word_operator, sym_operator
    end

    components = maths.split(' ')

    # Pattern: number operator number [operator number...]
    value = components.shift # First number
    until components.empty?
      operator = components.shift

      # Must be a recognized math operation
      raise ArgumentError unless OPS.values.include? operator

      number = components.shift
      value = eval("#{value}#{operator}#{number}")
    end
    value
  end
end
