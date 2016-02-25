class Clock
  attr_reader :hours, :minutes

  def initialize(hours = 0, minutes = 0)
    @hours, @minutes = hours, minutes
  end

  def to_s
    "%02d:%02d" % [hours, minutes]
  end

  def +(minutes)
    @minutes += minutes % 60
    @hours += minutes / 60
    @hours = hours % 24
    self
  end

  def -(mins)
    @minutes -= mins
    until minutes >= 0 do
      @minutes += 60
      @hours -= 1
    end
    
    until hours >= 0 do
      @hours += 24
    end
    self
  end

  def ==(other)
    hours == other.hours && minutes == other.minutes
  end

  def self.at(hours, minutes = 0)
    Clock.new(hours, minutes)
  end
end