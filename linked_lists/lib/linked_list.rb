require_relative "node"

class LinkedList #represents the full list
  attr_accessor :head, :tail
  
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value) #adds new node containing value to end of list
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
    elsif @tail == nil
      @tail = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
  end

  def prepend(value) #adds new node containing value to start of list
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def size #returns size/length of list
    i = 0
    current_node = @head
    while current_node != nil
        i += 1
        current_node = current_node.next_node
    end
    i
  end

  def head #returns the first node in list
    @head
  end

  def tail #returns the last node in list
    @tail
  end

  def at(index) #returns the node at the given index
    i = 0
    current_node = @head
    while current_node != nil
    node_index = i
      if node_index == index
        return current_node
      end
    i += 1
    current_node = current_node.next_node
    end
  end

  def pop #removes the last element from the list
    current_node = @head
    until current_node.next_node == @tail
      current_node = current_node.next_node
    end
    current_node.next_node = nil
    @tail = current_node
  end

  def contains?(value) #returns true if passed-in value is in the list and otherwise returns false
    i = 0
    current_node = @head
    answer = false 
    while i <= self.size
      if current_node.value == value
        answer = true
        break
      end
      current_node = current_node.next_node
      i += 1
    end
    return answer
  end

  def find(value) #returns the index of the node containing value, or nil if not found.
    i = 0
    current_node = @head
    if self.contains?(value) == true 
      while i <= self.size
        if current_node.value == value
        node_index = i
        end
      current_node = current_node.next_node
        if current_node == nil
          break
        end
       i += 1
      end
    return node_index
    else
      return nil
    end
  end

  def to_s #displays list as a string
    current_node = @head
    until current_node == nil
      print "(#{current_node.value}) -> "
      current_node = current_node.next_node
    end
    if current_node == nil
      print "nil"
    end
  end

  def insert_at(value, index) #inserts a new node with the provided value at given index
    previous_node = self.at(index - 1)
    current_node = self.at(index)
    if current_node.next_node == nil
      self.append(value)
    elsif previous_node == nil
      self.prepend(value)
    else
      new_node = Node.new(value, current_node)
      previous_node.next_node = new_node
    end
  end

  def remove_at(index) #removes the node at given index
    node_to_remove = self.at(index)
    previous_node = self.at(index - 1)
    next_node = self.at(index + 1)
    if next_node == nil
      self.pop
    else
    previous_node.next_node = next_node
    node_to_remove.next_node = nil
    end
  end
end

class Node
    attr_accessor :value, :next_node
  
    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end
  
    def display_node
      puts "data: #{@value}, next_node: #{@next_node}"
    end
end