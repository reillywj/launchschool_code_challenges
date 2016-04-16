# Breakdown is common code for finding the simple counts of values within an array or collection.
require 'pry'
module Breakdown
  attr_reader :breakdown

  def find_breakdown(arr = nil)
    @breakdown = {}
    breakdown_proc = proc do |val|
      @breakdown[val] = 0 unless @breakdown[val]
      @breakdown[val] += 1
    end

    if block_given?
      yield.each { |val| breakdown_proc.call(val) }
    else
      arr.each { |val| breakdown_proc.call(val) }
    end

    @breakdown = @breakdown.to_a.sort { |a, b| a.first <=> b.first }.to_h
  end

  def show_breakdown(num = nil)
    output = ''

    proc_breakdown = proc { |pair| output << "[#{pair.first}: #{'*' * pair[-1]}]\n" }
    arr_breakdown = breakdown.to_a
    case num
    when -arr_breakdown.size..-1
      arr_breakdown[num, num.abs].reverse_each { |pair| proc_breakdown.call(pair) }
    else
      arr_breakdown[0, num || breakdown.size].each { |pair| proc_breakdown.call(pair) }
    end

    output
  end
end