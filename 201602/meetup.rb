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
    search(weekday) { Date.new(year, month, 13) }
  end
  
  def first(weekday)
    search(weekday)
  end
  
  def second(weekday)
    search(weekday) { Date.new(year, month, starter(2)) } 
  end
  
  def third(weekday)
    search(weekday) { Date.new(year, month, starter(3)) }
  end
  
  def fourth(weekday)
    search(weekday) { Date.new(year, month, starter(4)) }
  end
  
  def last(weekday)
    base_date = Date.new(year, month, 1)
    starter_date = base_date.next_month - 1
    until Kernel.eval("starter_date." + weekday.to_s + "?") do
      starter_date -= 1
    end
    starter_date
  end
  
  def search(weekday)
    starter_date = if block_given?
                     yield
                   else
                     Date.new(year, month, 1)
                   end
    until Kernel.eval("starter_date." + weekday.to_s + "?") do
      starter_date += 1
    end
    starter_date
  end
  
  def starter(num)
    7 * (num - 1) + 1
  end
end