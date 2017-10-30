require_relative './node.rb'
#Using Adjancancy list to describe a directed graph

class Graph
  #set up Adjancancy table using a hash
  def initialize
    @nodes = Hash.new
    @node_dir_ancestors = Hash.new
  end

  #get the lowest common ancestor of two nodes in the graph
  def lowest_com_ancestor(node1, node2)
    
  end

  #add a new node to the graph
  def add_node(new_node)
    @nodes[new_node] ||= Array.new  #only adds if not in graph
    @node_dir_ancestors[new_node] ||= Array.new
  end

  #add an edge from from_node to to_node by appending to_node to the
  #end of the Array at hash[from_node]
  def add_edge(from_node, to_node)
    add_node(from_node)
    add_node(to_node)
    @nodes[from_node] << to_node
    @node_dir_ancestors[to_node] << from_node

    if self.has_cycle
      puts "No longer DAG"
    end
  end

  #is this node in the graph?
  def contains(node)
    return !(@nodes[node] == nil)
  end

  #is the edge from from_node to to_node in the graph?
  def has_edge(from_node, to_node)
    return @nodes[from_node].include?(to_node)
  end

  #method to check for cycles. DAG should have none
  def has_cycle
    @nodes.each do |node, dest_nodes|
      marked = [node]   #visited nodes are marked
      cycle_found = cycle_dfs(marked, dest_nodes)

      if cycle_found
        return true   #quit immediately if cycle found
      end
      #clear for next pass
      marked = []
    end

    return false  #no cycles found if we reach this point
  end

  #private method for recursive dfs to check for cycles
  private def cycle_dfs(marked, node_array)
    node_array.each do |dest|
      #if dest node is already visited on this path
      #there is a cycle, cycle found is passed back
      if marked.include?(dest)
        return true
      else
        marked << dest      #add node to path array
        #recursive call, if cycle found we quit
        cycle = cycle_dfs(marked, @nodes[dest])
        if cycle
          return cycle
        end
        #clear this node so each path is clean
        marked.delete(dest)
      end
    end
    #no cycles found!
    return false
  end
end
