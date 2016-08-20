# Triplet
class Triplet
  attr_reader :numbers

  def initialize(a, b, c)
    @numbers = [a, b, c]
  end

  def sum
    numbers.inject(&:+)
  end

  def product
    numbers.inject(&:*)
  end

  def pythagorean?
    numbers[0]**2 + numbers[1]**2 == numbers[2]**2
  end

  def self.where(args)
    min_factor = args[:min_factor] || 1
    max_factor = args[:max_factor]
    triplets = []
    (min_factor..max_factor).each do |a|
      (a..max_factor).each do |b|
        (b..max_factor).each do |c|
          triplet = new(a, b, c)
          verification = triplet.pythagorean?
          verification &&= triplet.sum == args[:sum] if args[:sum]

          triplets << triplet if verification
        end
      end
    end

    triplets
  end
end
