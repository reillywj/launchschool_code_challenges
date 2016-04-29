require 'pry'

# Finds Pascals Triangle
class Triangle
  attr_reader :rows

  def initialize(number)
    number.times do |row_number|
      case row_number
      when 0
        @rows = [[1]]
      else
        build(row_number)
      end
    end
  end

  private

  # def build
  #   (1..@levels).to_a.each do |level|
  #     case level
  #     when 1
  #       @rows = [[1]]
  #     else
  #       find_row(level)
  #     end
  #   end
  #   @rows
  # end

  def build(count)
    prior_row = @rows[count - 1]
    current_row = []
    (count + 1).times do |i|
      a = i - 1 < 0 ? 0 : prior_row[i - 1]
      b = prior_row[i] || 0
      current_row << a + b
    end

    @rows << current_row
  end
end
