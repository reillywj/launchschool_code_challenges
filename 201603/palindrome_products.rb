# Started at 8:50PM
# Completed 9:29PM

# Limitable is used to mixin common methods in the palindromic classes
module Limitable
  def min_factor
    @limits[:min_factor] || 1
  end

  def max_factor
    @limits[:max_factor]
  end
end

# Palindromes finds all palindromic numbers between two given factors
class Palindromes
  include Limitable

  def initialize(factor_limits)
    @limits = factor_limits
  end

  def generate
    @numbers = []
    (min_factor..max_factor).each do |i|
      (min_factor..max_factor).each do |j|
        @numbers << PalindromicNumber.new(i * j, @limits) if palindromic?(i, j)
      end
    end
    @numbers.sort!
  end

  def largest
    @numbers[-1]
  end

  def smallest
    @numbers.first
  end

  private

  def palindromic?(num1, num2)
    value = (num1 * num2).to_s
    value.eql? value.reverse
  end
end

# Class to store a single Palindromic number
# it has its own methods that can be called on it
class PalindromicNumber
  include Limitable

  attr_reader :value

  def initialize(number, factors)
    @value = number
    @limits = factors
  end

  def <=>(other)
    value <=> other.value
  end

  def factors
    factors = []
    (min_factor..max_factor).each do |i|
      (min_factor..max_factor).each do |j|
        factors << [i, j].sort if i * j == value
      end
    end
    factors.uniq
  end
end
