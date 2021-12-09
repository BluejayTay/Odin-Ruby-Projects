
class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end

class Tree
  attr_accessor :root, :tree_array

  def initialize(array)
    @tree_array = array.sort.uniq
    @root = build_tree(tree_array)
  end

  def build_tree(array)
    if array.length < 1
      return nil
    else

    mid = (array.length - 1) / 2
    root = Node.new(array[mid])

    root.left_child = build_tree(array[0...mid])
    root.right_child = build_tree(array[(mid + 1)..-1])
    puts root
    root
    end 
  end

# to visualize binary search tree, method by student on Discord
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value, node = root)
    if value == node.data
      puts "Cannot add #{value} because it already exits in the BST"
      return nil
    end
    if value < node.data
      if node.left_child == nil
        node.left_child = Node.new(value)
      else
        insert(value, node.left_child)
      end
    else value > node.data
      if node.right_child == nil
        node.right_child = Node.new(value)
      else
        insert(value, node.right_child)
      end
    end
  end
  
  def delete(value, node = root)
    if node == nil
      return node
    end

    if value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    end

    # node has 1 or 0 children
    if value == node.data
      if node.left_child == nil
        node = node.right_child
      elsif node.right_child == nil
        node = node.left_child
    # node has more than 1 child    
      else
        node.data = smallest_leaf(node.right_child)
        node.right_child = delete(node.data, root.right_child)
      end
    end 
    node
  end

  def find(value, node = root)
    if node == nil || node.data == value
      return node
    else
      if value < node.data
        find(value, node.left_child)
      elsif value > node.data
        find(value, node.right_child)
      end
    end
  end

  # Method for breadth-first traversal of BST
  def level_order
    i = 0
    queue = [@root]
    level_array = []
    while queue[i]
      level_array << queue[i].data
      if queue[i].left_child != nil
        queue << queue[i].left_child
      end
      if queue[i].right_child != nil
      queue << queue[i].right_child
      end
      i += 1
    end
    level_array
  end

  # The following 3 methods are for depth-first traversal of the BST

  # vist root, left_subtree, right_subtree
  def preorder(node = root, array = [])
    if node == nil
      return
    else
    array << node.data
    preorder(node.left_child, array)
    preorder(node.right_child, array)
    end
    array
  end

  # vist left_subtree, root, right_subtree (returns a sorted list)
  def inorder(node = root, array = [])
    if node == nil
      return
    else
    inorder(node.left_child, array)
    array << node.data
    inorder(node.right_child, array)
    end
    array
  end

  # vist left_subtree, right_subtree, root 
  def postorder(node = root, array = [])
    if node == nil
      return
    else
    postorder(node.left_child, array)
    postorder(node.right_child, array)
    array << node.data
    end
    array
  end

  # height: number of edges from a node to the lowest leaf in it's longest subtree
  def height(node = @root)
    unless node == nil || node == @root
      node = find(node.data) 
    end
    if node == nil
      return -1
    else
    [height(node.left_child), height(node.right_child)].max + 1
    end
  end

  # depth: the number of edges in path from a given node to the tree’s root node.
  def depth(node)
    height(@root) - height(node)
  end

  # balanced tree: the difference between heights of left subtree and right subtree of every node is not more than 1.
  def balanced?
    array = self.postorder
    height_differences = []
    i = 0
    while i <= array.length - 1
      node = self.find(array[i])
      l_height = height(node.left_child)
      r_height = height(node.right_child)
      if l_height + r_height == -2
        height_differences << 0
      else 
      height_difference = [l_height, r_height].max - [l_height, r_height].min
      height_differences << height_difference
      end
      i += 1
    end
    if height_differences.any? {|num| num > 1}
      return false
    else
      return true
    end
  end

  def rebalance
    @tree_array = inorder(root)
    @root = self.build_tree(@tree_array)
  end

  # helper method for delete
  def smallest_leaf(node)
    until node.left_child == nil
      node = node.left_child
    end
    return node
  end

end

# driver script
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "Welcome to Taylor's 'tree farm'!"
puts " "
puts "Generating binary search tree from an array of random numbers 1-100..."
array = Array.new(15) { rand(1..100) }
spruce = Tree.new(array)
puts "A visual representation of the tree"
spruce.pretty_print
puts "Is this tree balanced?"
p spruce.balanced?
puts "level order:"
p spruce.level_order
puts "Preorder:"
p spruce.preorder
puts "Inorder"
p spruce.inorder
puts "Postorder"
p spruce.postorder
puts "Adding several elements > 100 to unbalance tree..."
spruce.insert(101)
spruce.insert(120)
spruce.insert(150)
spruce.insert(200)
spruce.insert(500)
spruce.insert(1000)
puts "New tree with added elements:"
spruce.pretty_print
puts "Is this tree balanced?"
p spruce.balanced?
puts "Alright, well let's re-balance it!"
spruce.rebalance
puts "Re-balanced tree:"
spruce.pretty_print
puts "Is it balanced now?"
p spruce.balanced?
puts "level order:"
p spruce.level_order
puts "Preorder:"
p spruce.preorder
puts "Inorder"
p spruce.inorder
puts "Postorder"
p spruce.postorder