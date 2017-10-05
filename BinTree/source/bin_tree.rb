#represents a binary tree with (key, value) nodes
require './node.rb'

class BinTree
  def initialize
    @root = nil
  end

  #Adds a new node to the Binary Tree in the correct location
  #If Already in tree, does nothing
  def add(root, new_node)
    #base
    if root.nil?
      @root = new_node
    elsif new_node < root
      add(root.left, new_node)
    elsif new_node > root
      add(root.right, new_node)
    #else do nothing
    end
  end

  #Returns whether this tree contains the node with the given
  # values
  def contains(root, desired_node)
    if root == desired_node
      return true
    elsif root.nil?
      return false
    elsif desired_node > root
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


  end

  attr_reader :root

end
