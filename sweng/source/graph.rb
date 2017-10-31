#Using an Adjancancy list to describe a directed acyclic graph
#Rough outline of Adjancancy list digraph in Ruby from
#http://www.se.rit.edu/~swen-250/activities/Ruby/DiGraph/PracticeActivity/DiGraph.rb

class Graph
  #set up Adjancancy list using a hash
  def initialize
    #Adjancancy list
    @nodes = Hash.new
    #weak link to immediate ancestors solely for checking lca
    @node_dir_ancestors = Hash.new
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

  #gets all of the lowest common ancestor of two nodes in the graph
  #returns them in an array
  def lowest_com_ancestor(node1, node2)
    ancestors_node1 = [node1]    #array of all node1's ancestors
    common_ancestors = []        #array of all common ancestors between node 1 and 2

    make_anc_arr(node1, ancestors_node1)    #build node1 ancestors array

    if ancestors_node1.include?(node2)
      common_ancestors << node2
    end

    make_common_anc_arr(node2, ancestors_node1, common_ancestors) #build common

    common_ancestors.each do |node|
      delete_anc(node, common_ancestors)  #delete nodes that aren't lowest
    end
    #return value:
    return common_ancestors
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

  #makes the array of node1's ancestors
  private def make_anc_arr(node, ancestors_node1)
    @node_dir_ancestors[node].each do |ancestor|
      if !(ancestors_node1.include?(ancestor))
        ancestors_node1 << ancestor
      end
      make_anc_arr(ancestor, ancestors_node1)
    end
  end

  #Makes the array containing all common ancestors
  private def make_common_anc_arr(node, ancestors_node1, common_ancestors)
    @node_dir_ancestors[node].each do |ancestor|
      if !(common_ancestors.include?(ancestor)) && ancestors_node1.include?(ancestor)
        common_ancestors << ancestor
      end
      make_common_anc_arr(ancestor, ancestors_node1, common_ancestors)
    end
  end

  #Deletes common ancestors that aren't the lowest
  private def delete_anc(node, common_ancestors)
    @node_dir_ancestors[node].each do |ancestor|
      if(common_ancestors.include?(ancestor))
        common_ancestors.delete(ancestor)
        delete_anc(ancestor, common_ancestors)
      end
    end
  end

end
