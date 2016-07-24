# Game of bowling.
class Game
  attr_accessor :score

  def initialize
    @frame           = Frame.new
    @roll            = 0
    @score           = 0
    @roll_multiplier = [1]
  end

  def roll(pins)
    raise 'Should not be able to roll after game is over' if gameover?
    tally_score pins
    @frame.roll pins
    set_multipliers
    @frame.next_frame if @frame.over?
    @roll += 1
  end

  def tally_score(pins)
    raise 'Pins must have a values from 0 to 10.' unless (0..10).cover? pins
    @score += @roll_multiplier[@roll] * pins
  end

  def set_multipliers
    initialize_multipliers
    return if @frame.number >= 10
    @roll_multiplier[@roll + 1] += 1 if @frame.ten?
    @roll_multiplier[@roll + 2] += 1 if @frame.strike?
  end

  def initialize_multipliers
    2.times { |num| @roll_multiplier[@roll + num + 1] ||= 1 }
  end

  def score
    raise 'Score cannot be taken until the end of the game' unless gameover?
    @score
  end

  def gameover?
    @frame > 10
  end
end

# A frame in bowling. This moves along from frame to frame.
class Frame
  attr_reader :number

  def initialize
    @number    = 1
    @rolls     = []
    @available = 10
  end

  def >(number)
    @number > number
  end

  def roll(pins)
    decrement pins
    @rolls << pins
    reset_pins
  end

  def decrement(pins)
    @available -= pins
    raise 'Pin count exceeds pins on the lane' if @available < 0
  end

  def reset_pins
    @available = 10 if ten? || max_rolls?
  end

  def ten?
    pins_down == 10 || strike?
  end

  def pins_down
    @rolls.inject(&:+)
  end

  def strike?
    @rolls.last == 10
  end

  def max_rolls
    (@number == 10 && pins_down >= 10) ? 3 : 2
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
