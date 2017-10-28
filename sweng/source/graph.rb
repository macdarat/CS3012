require_relative './node.rb'
#Using Adjancancy list to describe a directed graph

class Graph
  #set up Adjancancy table using a hash
  def initialize
    @nodes = Hash.new
    #@node_dir_ancestors = Hash.new
  end

  #get the lowest common ancestor of two nodes in the graph
  def lowest_com_ancestor(node1, node2)

  end

  #add a new node to the graph
  def add_node(new_node)
    @nodes[new_node] ||= Array.new  #only adds if not in graph
  end

  #add an edge from from_node to to_node by appending to_node to the
  #end of the Array at hash[from_node]
  def add_edge(from_node, to_node)
    add_node(from_node)
    add_node(to_node)
    @nodes[from_node] << to_node
    #@node_dir_ancestors[to_node] << from_node
  end

  #is this node in the graph?
  def contains(node)
    if @nodes[node] == nil
      return false
    else
      return true
    end
  end

  #is the edge from from_node to to_node in the graph?
  def has_edge(from_node, to_node)
    return @nodes[from_node].include?(to_node)
  end
end
