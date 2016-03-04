require 'minitest/autorun'
require_relative 'clock_19'

class ClockTest < Minitest::Test
  def test_on_the_hour
    assert_equal '08:00', Clock.at(8).to_s
    assert_equal '09:00', Clock.at(9).to_s
  end

  def test_past_the_hour
    assert_equal '11:09', Clock.at(11, 9).to_s
  end

  def test_add_a_few_minutes
    clock = Clock.at(10) + 3
    assert_equal '10:03', clock.to_s
  end

  def test_add_over_an_hour
    clock = Clock.at(10) + 61
    assert_equal '11:01', clock.to_s
  end

  def test_wrap_around_at_midnight
    clock = Clock.at(23, 30) + 60
    assert_equal '00:30', clock.to_s
  end

  def test_subtract_minutes
    clock = Clock.at(10) - 90
    assert_equal '08:30', clock.to_s
  end

  def test_subtract_minutes_2
    clock = Clock.at(10)-3
    assert_equal '09:57', clock.to_s
  end

  def test_equivalent_clocks
    clock1 = Clock.at(15, 37)
    clock2 = Clock.at(15, 37)
    assert_equal clock1, clock2
  end

  def test_inequivalent_clocks
    clock1 = Clock.at(15, 37)
    clock2 = Clock.at(15, 36)
    clock3 = Clock.at(14, 37)
    refute_equal clock1, clock2
    refute_equal clock1, clock3
  end

  def test_wrap_around_backwards
    clock = Clock.at(0, 30) - 60
    assert_equal '23:30', clock.to_s
  end
  
  def test_add_more_than_a_day
    clock = Clock.at(0, 30) + (24*60*4)
    assert_equal Clock.at(0, 30), clock
  end
  
  def test_subtract_more_than_a_day
    clock = Clock.at(0, 30) - (24*60*4)
    assert_equal Clock.at(0, 30), clock
  end

  def test_wrap_add_a_lot_of_days
    # with Time class, we might go from standard time to daylight savings time
    clock = Clock.at(0, 30) + 180 * 24 * 60
    assert_equal '00:30', clock.to_s
  end

  def test_wrap_subtract_one_day_and_a_bit
    # does it work if we subtract a bit more than a full day?
    clock = Clock.at(0, 30) - (24 * 60 + 15)
    assert_equal '00:15', clock.to_s
  end
end