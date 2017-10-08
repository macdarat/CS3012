#represents a binary tree with (key, value) nodes
require './node.rb'

class BinTree
  def initialize
    @root = nil
  end

  #Adds a new node to the Binary Tree in the correct location
  #If Already in tree, does nothing
  def add(new_node)
    if @root.nil?
      @root = new_node
    else
      add_rec(@root, new_node)
    end
  end

  #recursively adds node to tree
  private def add_rec(parent, new_node)
    if new_node.value < parent.value
      if parent.left.nil?
        parent.left = new_node
      else
        add_rec(parent.left, new_node)
      end

    elsif new_node.value > parent.value
      if parent.right.nil?
        parent.right = new_node
      else
        add_rec(parent.right, new_node)
      end

    else
      #else already in tree so do nothing
    end
  end


  #Returns whether this tree contains the node with the given
  # values
  def contains(root, desired_node)

    if root.nil? || desired_node.nil?
      return false
    elsif root.value == desired_node.value
      return true
    elsif desired_node.value > root.value
      return contains(root.right, desired_node)
    else
      return contains(root.left, desired_node)
    end
  end

  #Gets the lowest common ancestor node for the two nodes
  # passed as parameters
  def lowest_com_ancestor(node1, node2)
    if(!contains(@root, node1) || !contains(@root, node2))
      return nil
    end

    path1 = [@root]
    path2 = [@root]
    current_node = @root

    #build path from root to node1
    while current_node.value != node1.value
      if node1.value < current_node.value
        current_node = current_node.left
        path1.push(current_node)
      else
        current_node = current_node.right
        path1.push(current_node)
      end
    end

    current_node = @root
    #build path from root to node2
    while current_node.value != node2.value
      if node2.value < current_node.value
        current_node = current_node.left
        path2.push(current_node)
      else
        current_node = current_node.right
        path2.push(current_node)
      end
    end

    (path1.length - 1).downto(0) do |i|
      if path2.include?(path1[i])
        return path1[i]
      end
    end

    puts "nil"
    return nil

  end

  attr_reader :root

end
