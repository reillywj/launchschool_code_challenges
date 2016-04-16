require 'pry'

class Product
  attr_reader :subsets
  def initialize(filename)
    @number = IO.readlines(filename).join('').gsub("\n", '')
  end

  def find_subsets(n=13)
    return @subsets if @subsets

    @subsets = []
    (@number.size - n + 1).times do |index|
      @subsets << Subset.new(@number[index, n])
    end
  end

  def find_largest_product_subset(n=13)
    find_subsets(n) unless @subsets
    @subsets.sort[-1]
  end
end

class Subset
  def initialize(subset)
    @subset = subset
    @numbers = {}
    subset.split('').each do |num|
      @numbers[num] = 0 unless @numbers[num]
      @numbers[num] += 1
    end
  end

  def product
    return @product if @product
    return 0 if @numbers['0']
    value = 1
    @numbers.each do |number, count|
      value *= (number.to_i**count.to_i)
    end
    @product = value
  end

  def <=>(other)
    self.product <=> other.product
  end
end

binding.pry