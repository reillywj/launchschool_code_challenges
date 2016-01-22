require 'pry'

# CircularBuffer class:
# uses a single, fixed-size buffer as if it were connected end-to-end
class CircularBuffer
  attr_accessor :buffer
  attr_reader :buffer_limit

  # Buffer is empty
  class BufferEmptyException < StandardError
    def initialize
    end
  end

  # Buffer is at full capacity
  class BufferFullException < StandardError
    def initialize
    end
  end

  def initialize(buffer_size)
    @buffer = []
    @buffer_limit = buffer_size
  end

  def read
    fail BufferEmptyException if @buffer.empty?
    @buffer.shift unless @buffer.empty?
  end

  def write(value)
    if too_big?
      fail BufferFullException
    else
      @buffer << value unless value.nil?
    end
  end

  def write!(value)
    # rubocop:disable GuardClause
    unless value.nil?
      @buffer.shift if too_big?
      write value
    end
    # rubocop:enable GuardClause
  end

  def clear
    @buffer = []
  end

  private

  def too_big?
    buffer.size >= buffer_limit
  end
end
