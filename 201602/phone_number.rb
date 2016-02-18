# PhoneNumber LaunchSchool Ruby Challenge
# By Will Reilly
# 18 February 2016
# If the phone number is less than 10 digits assume that it is bad number
# If the phone number is 10 digits assume that it is good
# If the phone number is 11 digits and the first number is 1, trim the 1 and use the last 10 digits
# If the phone number is 11 digits and the first number is not 1, then it is a bad number
# If the phone number is more than 11 digits assume that it is a bad number
class PhoneNumber
  attr_reader :number

  DEFAULT_NUMBER = '0' * 10

  def initialize(phone_number)
    @number = decipher phone_number
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{area_code}) #{@number[3..5]}-#{@number[6..9]}"
  end

  private

  def decipher(phone_number)
    return DEFAULT_NUMBER if letters? phone_number

    num = phone_number.split('').select { |char| char =~ /\d/ }.join

    case num.size
    when 10 then num
    when 11 then num.start_with?('1') ? num[1..10] : DEFAULT_NUMBER
    else DEFAULT_NUMBER
    end
  end

  def letters?(phone_number)
    !!phone_number.index(/[A-z]/)
  end
end
