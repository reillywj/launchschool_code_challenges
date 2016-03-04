class Clock < Time
  def initialize(hour, min)
    @time = Time.at(hour * 60 * 60 + min * 60)
  end

  def self.at(hour = 0, min = 0)
    Clock.new(hour, min)
  end

  def to_s
    instance_variable_get(:@time).strftime("%H:%M")
  end

  def +(addend)
    instance_variable_set(:@time, (instance_variable_get(:@time) + addend * 60))
    self
  end

  def -(subend)
    instance_variable_set(:@time, (instance_variable_get(:@time) - subend * 60))
    self
  end

  def ==(other)
    instance_variable_get(:@time).eql?(other.instance_variable_get(:@time))
  end
end