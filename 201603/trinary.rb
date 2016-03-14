# Trinary converts a trinary number to a decimal (base 10)
class Trinary
  def initialize(input)
    @value = input.to_i.to_s
  end

  def to_decimal
    decimal = 0
    @value.reverse.split('').each_with_index do |num, index|
      decimal += num.to_i * 3**index
    end
    decimal
  end
end
