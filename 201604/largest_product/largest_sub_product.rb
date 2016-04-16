require 'pry'

class SubProductFinder
  attr_reader :number
  def initialize(filename)
    @number = IO.readlines(filename).join('').gsub("\n", '')
  end

  def find_largest_product_subset(n=13)
    find_subsets(n) unless @subsets
    @subsets.sort[-1]
  end

  def show_breakdown(num=nil)
    proc_breakdown = Proc.new do |pair|
      "[#{pair.first}: #{'*' * pair[-1]}]\n"
    end

    output = ''

    if num >= 0
      breakdown[0, num].each do |pair|
        output << proc_breakdown.call(pair)
      end
    elsif num < 0
      breakdown[num, num.abs].reverse.each do |pair|
        output << proc_breakdown.call(pair)
      end
    else
      breakdown.each do |pair|
        output << proc_breakdown.call(pair)
      end
    end
    puts output
  end

  def breakdown
    return @breakdown if @breakdown
    @breakdown = {}
    @subsets.each do |subset|
      product = subset.product
      @breakdown[product] = 0 unless @breakdown[product]
      @breakdown[product] += 1
    end
    @breakdown = @breakdown.to_a.sort { |a, b| a.first <=> b.first }
  end

  private

  def find_subsets(n=13)
    return @subsets if @subsets

    @subsets = []
    (@number.size - n + 1).times do |index|
      @subsets << Subset.new(@number[index, n])
    end
  end
end

class Subset
  attr_reader :number

  def initialize(subset)
    @number = subset
    @breakdown = {}
    subset.split('').each do |num|
      @breakdown[num] = 0 unless @breakdown[num]
      @breakdown[num] += 1
    end
  end

  def product
    return @product if @product
    return 0 if @breakdown['0']
    value = 1
    @breakdown.each do |number, count|
      value *= (number.to_i**count.to_i)
    end
    @product = value
  end

  def <=>(other)
    self.product <=> other.product
  end

  def to_s
    "#{self.number} => #{self.product}"
  end
end

problem = SubProductFinder.new('number.txt')
solution = problem.find_largest_product_subset(13)
puts "Problem: Find largest subset of a thousand digit number in number.txt file."
puts solution # 5576689664895 => 23514624000
puts "Top 10"
problem.show_breakdown(-10)
puts "Bottom 10"
problem.show_breakdown(10)
