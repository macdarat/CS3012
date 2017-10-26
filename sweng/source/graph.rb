require_relative './node.rb'
#Using Adjancancy list to describe a directed graph

class Graph
  #set up Adjancancy table using a hash
  def initialize
    @nodes = Hash.new
  end

  #get the lowest common ancestor of two nodes in the graph
  def lowest_com_ancestor(node1, node2)

  end

  #add a new node to the graph
  def add_node(new_node)
    @nodes[new_node] = Array.new
  end

  #add an edge from from_node to to_node by appending to_node to the
  #end of the Array at hash[from_node]
  def add_edge(from_node, to_node)
    @nodes[from_node] << to_node
  end

  def contains(node)
    if @nodes[node] == nil
      return false
    else
      return true
    end
  end
end
