# Breakdown is common code for finding the simple counts of values within an array or collection.
module Breakdown
  attr_reader :breakdown

  def find_breakdown(arr = nil)
    @breakdown = {}
    breakdown_proc = proc do |val|
      @breakdown[val] = 0 unless @breakdown[val]
      @breakdown[val] += 1
    end

    yield.each { |val| breakdown_proc.call(val) } if block_given?
    arr.each { |val| breakdown_proc.call(val) } unless block_given?

    @breakdown = @breakdown.to_a.sort { |a, b| a.first <=> b.first }.to_h
  end

  def show_breakdown(num = nil)
    output = ''

    proc_breakdown = proc { |pair| output << "[#{pair.first}: #{'*' * pair[-1]}]\n" }
    arr_breakdown = breakdown.to_a
    adj_num = if num && num.abs > arr_breakdown.size
      (num < 0 ? -1 : 1) * arr_breakdown.size
    else
      num
    end
      

    case adj_num
    when -arr_breakdown.size..-1
      arr_breakdown[adj_num, adj_num.abs].reverse_each { |pair| proc_breakdown.call(pair) }
    else
      arr_breakdown[0, adj_num || breakdown.size].each { |pair| proc_breakdown.call(pair) }
    end

    output
  end
end
