# PerfectNumber LaunchSchool Coding Challenge
# Completed: July 2, 2016
class PerfectNumber
  def self.classify(num)
    raise 'Invalid number' if num <= 0

    case sum_of_factors(num)
    when num      then 'perfect'
    when 0...num  then 'deficient'
    else
      'abundant'
    end
  end

  def self.divisors(num)
    divs = []

    (1..Integer(Math.sqrt(num))).each do |div|
      (divs << div) << (num / div) if num % div == 0
    end

    divs
  end

  def self.sum_of_factors(num)
    divisors(num).inject(&:+) - num
  end
end
