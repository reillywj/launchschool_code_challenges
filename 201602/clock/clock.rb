class Clock
  attr_reader :hours, :minutes

  def initialize(hours = 0, minutes = 0)
    @hours, @minutes = hours, minutes
  end

  def to_s
    '%02d:%02d' % [hours, minutes]
  end

  def +(other_minutes)
    @minutes += other_minutes % 60
    @hours += other_minutes / 60
    @hours = hours % 24
    self
  end

  def -(other_minutes)
    @minutes -= other_minutes
    until minutes >= 0
      @minutes += 60
      @hours -= 1
    end
    @hours += 24 until hours >= 0
    self
  end

  def ==(other)
    hours == other.hours && minutes == other.minutes
  end

  def self.at(hours, minutes = 0)
    Clock.new(hours, minutes)
  end
end
