require_relative 'graph.rb'
require_relative 'treenode.rb'
require_relative 'bin_tree.rb'
require 'minitest/spec'
require 'minitest/autorun'

class TestGraphAndTree < Minitest::Test

  #test graph set up
  def test_graph_init
    test_g = Graph.new
    puts "assert graph empty"
    assert !(test_g.contains("a"))
    test_g.add_node("a")
    puts "assert graph adds nodes"
    assert (test_g.contains("a"))
  end

  #test adding of edges is correct for a directed graph
  def test_graph_edges
    test_g = Graph.new
    test_g.add_edge("a", "b")
    puts "assert adding edge to a graph adds its nodes too"
    assert (test_g.contains("a"))

    puts "assert that edges are directed, ie not symmetric relation"
    assert test_g.has_edge("a","b")
    assert !(test_g.has_edge("b","a"))
  end

  def test_cycle_check
    test_g = Graph.new
    test_g.add_edge("a", "b")
    test_g.add_edge("a", "c")
    test_g.add_edge("b", "c")

    puts "assert graph cycle detection returns false on non cyclic graph"
    assert !(test_g.has_cycle)
    puts "assert graph detects cycles created when adding an edge"
    test_g.add_edge("c", "a")
    assert (test_g.has_cycle)
  end

  def test_graph_lca
    test_g = Graph.new
    test_g.add_edge("a", "b")       #       a -. f
    test_g.add_edge("a", "c")       #     /  \    .e .---\
    test_g.add_edge("b", "c")       #    .    . /         \
    test_g.add_edge("c", "d")       #    b -. c -. d .    |
    test_g.add_edge("c", "e")       #                 \  |
    test_g.add_edge("a", "f")       #                   g
    test_g.add_edge("g", "e")       # WHere a-.b means from a to b
    test_g.add_edge("g", "d")

    puts "-Testing LCA:"
    puts "test lca of simple cases"
    lca = test_g.lowest_com_ancestor("b", "f")
    assert_equal(1, lca.length)
    assert lca.include?("a")

    puts "test two nodes the same"
    lca = test_g.lowest_com_ancestor("g", "g")
    assert_equal(1, lca.length)
    assert lca.include?("g")

    puts "test that order doesn't matter"
    lca = test_g.lowest_com_ancestor("e", "f")
    assert_equal(1, lca.length)
    assert lca.include?("a")

    lca = test_g.lowest_com_ancestor("f", "e")
    assert_equal(1, lca.length)
    assert lca.include?("a")

    lca = test_g.lowest_com_ancestor("e", "c")
    assert_equal(1, lca.length)
    assert lca.include?("c")

    lca = test_g.lowest_com_ancestor("c", "e")
    assert_equal(1, lca.length)
    assert lca.include?("c")

    puts "testing lca on cases where there are multiple lcas to the nodes"
    lca = test_g.lowest_com_ancestor("e", "d")
    assert_equal(2, lca.length)
    assert lca.include?("g")
    assert lca.include?("c")

    lca = test_g.lowest_com_ancestor("d", "e")
    assert_equal(2, lca.length)
    assert lca.include?("g")
    assert lca.include?("c")

    puts "testing nil edge case"
    lca = test_g.lowest_com_ancestor("u", "e")
    assert_equal(0, lca.length)

    lca = test_g.lowest_com_ancestor("a", "x")
    assert_equal(0, lca.length)

    lca = test_g.lowest_com_ancestor(nil, nil)
    assert_equal(0, lca.length)

    puts "testing no lca"
    lca = test_g.lowest_com_ancestor("a", "g")
    assert_equal(0, lca.length)
  end
#==============================================================================#
  #bin_tree tests

  #Ensure that object attributes are correct
  def test_attrs
    #test BinTree attr
    tree = BinTree.new
    test_val = tree.root
    assert test_val == nil

    #test TreeNode value
    test_node = TreeNode.new(18)
    test_val = test_node.value
    assert_equal(test_val, 18)

    #test TreeNode left set value and read value
    test_left = TreeNode.new(1)
    test_node.left = test_left
    assert_equal(test_left, test_node.left)

    #test TreeNode right set value and read value
    test_right = TreeNode.new(23)
    test_node.right = test_right
    assert_equal(test_right, test_node.right)
  end

  #Ensure that the add method works correctly
  def test_add
    tree = BinTree.new
    #test empty
    assert tree.root == nil

    test_node =  TreeNode.new(6)
    tree.add(test_node)
    #test one node added
    assert_equal(tree.root, test_node)

    test_node =  TreeNode.new(4)
    tree.add(test_node)
    #test 2 nodes added
    assert_equal(test_node, tree.root.left)

    test_node =  TreeNode.new(9)
    tree.add(test_node)
    #test 3 nodes added
    assert_equal(test_node, tree.root.right)

    test_node =  TreeNode.new(-1)
    tree.add(test_node)
    #test 4 nodes added
    assert_equal(test_node, tree.root.left.left)
  end

  def test_contains
    tree = BinTree.new
    #test that nodes not in tree return false when tree is empty
    assert !(tree.contains(tree.root, TreeNode.new(8)))

    #add various nodes to the tree
    tree.add(TreeNode.new(8))
    tree.add(TreeNode.new(1))
    tree.add(TreeNode.new(4))
    tree.add(TreeNode.new(17))
    tree.add(TreeNode.new(-3))

    #test that these nodes on different paths return true for contains
    assert tree.contains(tree.root, TreeNode.new(8))
    assert tree.contains(tree.root, TreeNode.new(17))
    assert tree.contains(tree.root, TreeNode.new(-3))

    #test that these node that aren't in the tree return false
    #tests on value
    assert !(tree.contains(tree.root, TreeNode.new(99)))
    assert !(tree.contains(tree.root, TreeNode.new(0)))

  end

  #test finding the lowest common ancestor
  def test_lca
    #build the following tree
    tree = BinTree.new
    tree.add(TreeNode.new(8))    # =>      8
    tree.add(TreeNode.new(1))    # =>    /   \
    tree.add(TreeNode.new(4))    # =>   1     17
    tree.add(TreeNode.new(17))   # =>  / \
    tree.add(TreeNode.new(-3))   # =>-3   4

    #test lca for two child nodes of root is root
    x = tree.lowest_com_ancestor(TreeNode.new(17), TreeNode.new(1))
    assert_equal(8, x.value)

    #test one node being the parent of the other returns the parent
    x = tree.lowest_com_ancestor(TreeNode.new(4), TreeNode.new(1))
    assert_equal(1, x.value)

    #test far sides of tree return root
    x = tree.lowest_com_ancestor(TreeNode.new(-3), TreeNode.new(17))
    assert_equal(8, x.value)

    #test negative value works normally
    x = tree.lowest_com_ancestor(TreeNode.new(4), TreeNode.new(-3))
    assert_equal(1, x.value)

    #test that if both nodes are the same, returns that node
    x = tree.lowest_com_ancestor(TreeNode.new(17), TreeNode.new(17))
    assert_equal(17, x.value)

    #test negative with root itself returns root
    x = tree.lowest_com_ancestor(TreeNode.new(-3), TreeNode.new(8))
    assert_equal(8, x.value)

    #test node not in tree
    x = tree.lowest_com_ancestor(TreeNode.new(-7), TreeNode.new(8))
    assert x == nil

    #test nil node
    x = tree.lowest_com_ancestor(nil, TreeNode.new(-3))
    assert x == nil
  end

end
