class PerfectNumber
  def self.classify(num)
    raise "Invalid number" if num <= 0
    case sum_of_factors(num)
    when num
      "perfect"
    when 0...num
      "deficient"
    else
      "abundant"
    end
  end

  private

  def self.divisors(num)
    divs = []

    (1..Integer(Math.sqrt(num))).each do |div|
      (divs << div) << (num / div) if num % div == 0
    end

    return divs
  end

  def self.sum_of_factors(num)
    divisors(num).inject(0, &:+) - num
  end
end