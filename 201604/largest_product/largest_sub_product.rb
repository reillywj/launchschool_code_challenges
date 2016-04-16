# LaunchSchool Challenge
# From Project Euler problem #8
# Find the thirteen(13) adjacent digits in the 1000-digit number that have the greatest product.
# What is the value of this product?

# Use pry gem if you want to play around.
# require 'pry'
require_relative 'breakdown'

# SubProductFinder: Finds the sub products of a Number
module SubProductFinder
  # Main Number
  class Number
    attr_reader :number

    include Breakdown

    def initialize(number)
      raise ArgumentError unless Integer(number)
      @number = number.to_s
    end

    def find_largest_product_subset(n)
      find_subsets(n) unless @subsets && @subsets.first.size == n
      @subsets[-1]
    end

    def largest_distance_between(num = 0)
      largest = 0
      current_distance = 0
      check_distance = proc { largest = current_distance if largest < current_distance }
      @number.split('').each do |digit|
        if digit == num.to_s
          check_distance.call
          current_distance = 0
        else
          current_distance += 1
        end
      end
      check_distance.call
      largest
    end

    private

    def find_subsets(n)
      return @subsets if @subsets && @subsets.first.size == n
      @subsets = []
      (@number.size - n + 1).times do |index|
        @subsets << Subset.new(@number[index, n])
      end
      @subsets.sort!
      find_breakdown(@subsets.map(&:product))
    end
  end

  # Subset takes a subset of digits and parses them into digit statistics
  # Also finds and stores the product of these digits
  class Subset
    attr_reader :number

    include Breakdown

    def initialize(subset)
      @number = subset
      find_breakdown do
        subset.split('').map(&:to_i)
      end
    end

    def product
      return @product if @product
      return @product = 0 if @breakdown['0']

      @product = @breakdown.reduce(1) do |memo, (number, count)|
        memo * number**count
      end
    end

    def size
      @number.size
    end

    def <=>(other)
      product <=> other.product # Comparing for sorting
    end

    def to_s
      "Digits: #{number}\nBreakdown:\n#{show_breakdown}Product: #{product}"
    end
  end
end
# Running the Solution

def title(words, chars = 50)
  puts words.center(chars, '-')
end

problem = SubProductFinder::Number.new(IO.readlines('number.txt').join('').delete("\n"))
solution = problem.find_largest_product_subset(13)
puts "\nProblem: Find largest subset of a thousand digit number in number.txt file."
title 'Solution'
puts solution # 5576689664895 => 23514624000

# Metrics
title 'Top 10'
puts problem.show_breakdown(-10)
title 'Bottom 10'
puts problem.show_breakdown(10)
# title 'All'
# puts problem.show_breakdown #Shows all possible subset products

# Use binding.pry to play around if you'd like.
# binding.pry