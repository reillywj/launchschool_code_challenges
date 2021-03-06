# Finds the nth prime number
class Prime
  def self.nth(number)
    raise ArgumentError if number <= 0
    case number
    when 1
      2
    else
      count = 2
      current_number = 3
      prime = 2
      until count > number
        if is_prime?(current_number)
          prime = current_number
          count += 1
        end
        current_number += 2
      end
      prime
    end
  end

  private

  def self.is_prime?(number)
    prime = true
    counter = 2
    until counter > Math.sqrt(number)
      prime &&= (number % counter) != 0
      break unless prime
      counter += 1
    end
    prime
  end
end


# class Prime
#   def self.nth(number)
#     raise ArgumentError if number <= 0

#     primes = [2]
#     current_number = 3
#     until primes.size == number
#       is_prime = true
#       primes.each do |prime|
#         is_prime &&= (current_number % prime) != 0
#         break unless is_prime
#         break if prime > Math.sqrt(current_number)
#       end
#       primes << current_number if is_prime
#       current_number += 2
#     end
#     primes.last
#   end
# end
