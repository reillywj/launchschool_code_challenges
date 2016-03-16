require 'pry'

class Palindromes
  PalindromicNumber = Struct.new(:value, :factors)

  def initialize(args)
    @min_factor = args[:min_factor] || 1
    @max_factor = args[:max_factor]
  end

  def generate
  end

  def largest
    find_largest unless @largest
    @largest
  end

  def smallest
    find_smallest unless @smallest
    @smallest
  end
  private

  def find_largest
    unless @largest
      (@min_factor..@max_factor).reverse_each do |first_factor|
        (@min_factor..first_factor).each do |second_factor|
          if @largest
            smallest_factor = @largest.factors.flatten.min
            return if first_factor < smallest_factor && second_factor < smallest_factor
          end

          if palindromic?(first_factor * second_factor)
            value = first_factor * second_factor
            factors = [first_factor, second_factor].sort

            if @largest
              case value <=> @largest.value
              when 0
                @largest.factors << factors
              when 1
                # puts "#{value}: #{first_factor}; #{second_factor}"
                @largest = PalindromicNumber.new(value, [factors])
              end 
            else
              @largest = PalindromicNumber.new(value, [factors])
            end
          end
        end
      end
    end
  end

  def find_smallest
    unless @smallest
      (@min_factor..@max_factor).each do |first_factor|
        (@min_factor..first_factor).each do |second_factor|
          if @largest
            largest_factor = @smallest.factors.flatten.min
            return if first_factor > largest_factor && second_factor < largest_factor
          end

          if palindromic?(first_factor * second_factor)
            value = first_factor * second_factor
            factors = [first_factor, second_factor].sort
            if @smallest
              case value <=> @smallest.value
              when 0
                @smallest.factors << factors
              when -1
                @smallest = PalindromicNumber.new(value, [factors]) if @smallest.value > value
              end
            else
              @smallest = PalindromicNumber.new(value, [factors])
            end
          end
        end
      end
    end
  end

  def palindromic?(number)
    number.to_s == number.to_s.reverse
  end
end
