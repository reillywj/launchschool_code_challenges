# Element of Simple Linked List
class Element
  def initialize(node, next_node = nil)
    @node           = node
    @next_node      = next_node
  end

  def datum
    @node
  end

  def tail?
    @next_node.nil?
  end

  def next
    @next_node
  end
end

# Simple Linked List of elements
class SimpleLinkedList
  attr_accessor :elements
  def initialize
    @elements = []
  end

  def size
    elements.size
  end

  def empty?
    elements.empty?
  end

  def push(value)
    next_node = elements.first || nil
    elements.unshift Element.new(value, next_node)
  end

  def peek
    retrieve { elements.first.datum }
  end

  def head
    retrieve { elements.first }
  end

  def retrieve
    case elements.size
    when 0 then nil
    else
      yield if block_given?
    end
  end

  def pop
    elements.shift.datum
  end

  def to_a
    new_arr = []
    elements.each do |element|
      new_arr << element.datum
    end
    new_arr
  end

  def self.from_a(arr)
    new_linked_list = new
    return new_linked_list if arr.nil? || arr.empty?
    arr.reverse_each do |value|
      new_linked_list.push value
    end
    new_linked_list
  end

  def reverse
    SimpleLinkedList.from_a to_a.reverse
  end

  private :retrieve
end
