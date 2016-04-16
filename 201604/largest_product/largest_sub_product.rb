# LaunchSchool Challenge
# From Project Euler problem #8
# Find the thirteen(13) adjacent digits in the 1000-digit number that have the greatest product.
# What is the value of this product?

# Breakdown is common code for finding the simple counts of values within an array or collection.
module Breakdown
  attr_reader :breakdown

  def find_breakdown(arr = nil)
    @breakdown = {}
    breakdown_proc = proc do |val|
      @breakdown[val] = 0 unless @breakdown[val]
      @breakdown[val] += 1
    end
    if block_given?
      yield.each { |val| breakdown_proc.call(val) }
    else
      arr.each { |val| breakdown_proc.call(val) }
    end
    @breakdown = @breakdown.to_a.sort { |a, b| a.first <=> b.first }.to_h
  end

  def show_breakdown(num = nil)
    output = ''

    proc_breakdown = proc { |pair| output << "[#{pair.first}: #{'*' * pair[-1]}]\n" }
    arr_breakdown = breakdown.to_a
    case num
    when -arr_breakdown.size..-1
      arr_breakdown[num, num.abs].reverse_each { |pair| proc_breakdown.call(pair) }
    else
      arr_breakdown[0, num || breakdown.size].each { |pair| proc_breakdown.call(pair) }
    end

    output
  end
end

# SubProductFinder: Finds the sub products
class SubProductFinder
  attr_reader :number

  include Breakdown

  def initialize(filename)
    @number = IO.readlines(filename).join('').delete("\n")
  end

  def find_largest_product_subset(n = 13)
    find_subsets(n) unless @subsets
    @subsets.sort[-1]
  end

  def breakdown
    return @breakdown if @breakdown
    find_breakdown(@subsets.map(&:product))
  end

  private

  def find_subsets(n = 13)
    return @subsets if @subsets

    @subsets = []
    (@number.size - n + 1).times do |index|
      @subsets << Subset.new(@number[index, n])
    end
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
    return 0 if @breakdown['0']
    value = 1
    @breakdown.each do |number, count|
      value *= (number**count)
    end
    @product = value
  end

  def <=>(other)
    product <=> other.product
  end

  def to_s
    "Digits: #{number}\nBreakdown: #{breakdown}\nProduct: #{product}"
  end
end

# Running the Solution

def title(words)
  puts words.center(50, '-')
end

problem = SubProductFinder.new('number.txt')
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
