require 'pry'

# OCR Number Challenge
class OCR
  # attr_reader :text

  def initialize text
    @rows = text.split("\n\n")
    @rows.map! { |row| row.split("\n") }
    @rows.each do |row|
      row.map! { |text| (text.length % 3 == 0 && text.length > 0)? text : text + ' ' * (3 - text.length % 3) }
    end

    @digit_rows = []
    @rows.each_with_index do |row, index|
      @digit_rows[index] = Array.new(row.first.length / 3) { Digit.new }
    end

    # @text = text.split "\n"
    # @text.map! { |text| text.length % 3 == 0 ? text : text + ' ' * (3 - text.length % 3) }
    # @digits = Array.new(@text.first.length / 3) { Digit.new}
  end

  def convert
    read_text_by_row
    translate_digits
  end

  def read_text_by_row
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |symbol_row, symbol_index|
        @digit_rows[row_index].each_with_index do |digit, digit_index|
          digit.add symbol_index, symbol_row[digit_range digit_index]
        end
      end
    end
    # text.each_with_index do |row, row_index|
    #   @digits.each_with_index do |digit, digit_index|
    #     digit.add row_index, row[digit_range digit_index]
    #   end
    # end
  end

  def digit_range digit_index
    # 0 -> 0..2
    # 1 -> 3..5
    # 2 -> 6..8
    start = digit_index * 3
    ending = start + 2
    start..ending
  end

  def translate_digits
    # @digits.reduce('') { |number, next_digit| number + next_digit.to_s }
    @digit_rows.map { |digit_row| digit_row.reduce ('') { |number, next_digit| number + next_digit.to_s }}.join(',')
  end

  private :read_text_by_row, :translate_digits
end

class Digit
  OCR_TRANSLATION = {
    [' _ ', '| |', '|_|'] => 0,
    ['   ', '  |', '  |'] => 1,
    [' _ ', ' _|', '|_ '] => 2,
    [' _ ', ' _|', ' _|'] => 3,
    ['   ', '|_|', '  |'] => 4,
    [' _ ', '|_ ', ' _|'] => 5,
    [' _ ', '|_ ', '|_|'] => 6,
    [' _ ', '  |', '  |'] => 7,
    [' _ ', '|_|', '|_|'] => 8,
    [' _ ', '|_|', ' _|'] => 9
  }

  def initialize
    @rows = Array.new(3, '')
  end

  def add row_index, row
    @rows[row_index] = row
  end

  def to_i
    OCR_TRANSLATION[@rows] || '?'
  end

  def to_s
    to_i.to_s
  end
end
