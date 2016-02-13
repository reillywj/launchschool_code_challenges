require 'date'

class Meetup
  attr_reader :month, :year
  
  def initialize(month, year)
    @month = month
    @year = year
  end
  
  def day(weekday, schedule)
    send(schedule, weekday)
  end
  
  private
  
  def teenth(weekday)
    search(weekday, 13)
  end
  
  def first(weekday)
    search(weekday)
  end
  
  def second(weekday)
    search(weekday, start_day(2))
  end
  
  def third(weekday)
    search(weekday, start_day(3))
  end
  
  def fourth(weekday)
    search(weekday, start_day(4))
  end
  
  def last(weekday)
    base_date = Date.new(year, month, 1)
    starter_date = base_date.next_month - 1
    until Kernel.eval("starter_date." + weekday.to_s + "?") do
      starter_date -= 1
    end
    starter_date
  end
  
  def search(weekday, start_day = 1)
    starter_date = Date.new(year, month, start_day)
    until Kernel.eval("starter_date." + weekday.to_s + "?") do
      starter_date += 1
    end
    starter_date
  end
  
  def start_day(week_num)
    7 * (week_num - 1) + 1
  end
end