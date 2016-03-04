class Clock
  def initialize(hr, min)
    @time = Time.new(1970, 1, 1, hr, min)
  end

  def self.at(hr, min=0)
    new(hr, min) 
  end

  def self.original(time)
    new(time.hour, time.min)
  end

  def +(min)
    Clock.original(@time + min*60)
  end

  def -(min)
    Clock.original(@time - min*60)
  end

  def ==(other_time)
      to_s == other_time.to_s
  end

  def to_s
    @time.strftime("%H:%M")
  end
end