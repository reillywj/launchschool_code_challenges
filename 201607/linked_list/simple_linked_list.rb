# Element of Simple Linked List
class Element
  attr_reader :node

  def initialize(node, node_next = nil, node_previous = nil)
    @node          = node
    @node_next     = node_next
    # @node_previous = node_previous
  end

  def datum
    @node
  end

  def tail?
    @node_next.nil?
  end

  def next
    @node_next
  end
end

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

  def push(node)
    new_element = Element.new(node)
    prior_element = head
    elements.push Element.new(node)
  end

  def peek
    element = elements.last
    element.node unless element.nil?
  end

  def head
    elements.last
  end
end

# Simple Linked List of elements
# class SimpleLinkedList
#   attr_accessor :elements
#   def initialize
#     @elements = []
#   end

#   def size
#     elements.size
#   end

#   def empty?
#     elements.empty?
#   end

#   def push(value)
#     node_previous = elements.last || nil
#     node_next = Element.new(value, node_previous)
#     node_previous.next = node_next unless node_previous.nil?
#     elements.push node_next
#   end

#   def peek
#     retrieve { elements.first.datum }
#   end

#   def head
#     retrieve { elements.first }
#   end

#   def retrieve
#     case elements.size
#     when 0 then nil
#     else
#       yield if block_given?
#     end
#   end

#   def pop
#     elements.pop.datum
#   end

#   def to_a
#     new_arr = []
#     elements.each do |element|
#       new_arr.push element.datum
#     end
#     new_arr
#   end

#   def self.from_a(arr)
#     new_linked_list = new
#     return new_linked_list if arr.nil? || arr.empty?
#     arr.each do |value|
#       new_linked_list.push value
#     end
#     new_linked_list
#   end

#   def reverse
#     SimpleLinkedList.from_a to_a.reverse
#   end

#   private :retrieve
# end
