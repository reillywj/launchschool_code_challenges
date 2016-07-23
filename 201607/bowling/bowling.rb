require 'pry'

class Game
  attr_accessor :score

  def initialize
    @frame = Frame.new
    @roll = 0
    @score = 0
    @roll_multiplier = [1]
  end

  def roll(pins)
    raise "Should not be able to roll after game is over" if gameover?
    raise "Pins must have a values from 0 to 10." if !(0..10).include? pins
    @score += @roll_multiplier[@roll] * pins
    @frame.roll(pins)
    set_multipliers
    multiplier
    # puts self
    # puts "Pins: #{pins}"
    @frame.next_frame if @frame.over?
    @roll += 1
  end

  def to_s
    "Roll: #{@roll}; Score: #{@score}; Multiplier: #{@roll_multiplier}"
  end

  def multiplier
    return if @frame.number >=10
    @roll_multiplier[@roll + 1] += 1 if @frame.ten?
    @roll_multiplier[@roll + 2] += 1 if @frame.strike?
  end

  def set_multipliers
    @roll_multiplier[@roll + 1] ||= 1
    @roll_multiplier[@roll + 2] ||= 1
  end

  def score
    raise "Score cannot be taken until the end of the game" unless gameover?
    @score
  end

  def gameover?
    @frame.number > 10
  end
end

class Frame
  attr_reader :number

  def initialize(number=1, rolls = nil)
    @number = 1
    @rolls = rolls || []
    @available = 10
  end

  def roll(pins)
    @available -= pins
    raise "Pin count exceeds pins on the lane" if @available < 0
    @rolls << pins
    # binding.pry if @number == 10
    @available = 10 if ten? || max_rolls?
  end

  def ten?
    pins_down == 10 || @rolls.last == 10
  end

  def pins_down
    @rolls.inject(&:+)
  end

  def strike?
    ten? && @rolls.size == 1
  end

  def max_rolls
    if @number == 10 && pins_down >= 10
      3
    else
      2
    end
  end

  def max_rolls?
    @rolls.size >= max_rolls
  end

  def over?
    case @number
    when 10
      max_rolls?
    else
      max_rolls? || strike?
    end
  end

  def next_frame
    @number += 1
    @rolls = []
  end
end