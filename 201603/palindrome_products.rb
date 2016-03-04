# Started at 8:50PM
# Completed 9:29PM
require 'pry'
module Factorable
  def min_factor
    @limits[:min_factor] || 1
  end

  def max_factor
    @limits[:max_factor]
  end
end

class Palindromes
  include Factorable

  def initialize(arg)
    @limits = arg
  end

  def generate
    @numbers = []
    for i in (min_factor..max_factor)
      for j in (min_factor..max_factor)
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
    value == value.reverse
  end
end

class PalindromicNumber
  include Factorable

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
    for i in (min_factor..max_factor)
      for j in (min_factor..max_factor)
        factors << [i, j].sort if i * j == value
      end
    end
    factors.uniq
  end
end