require_relative 'graph.rb'
require_relative 'node.rb'
require_relative 'bin_tree.rb'
require 'minitest/spec'
require 'minitest/autorun'

class TestGraphAndTree < Minitest::Test

  #test graph set up
  def test_graph_init
    test_g = Graph.new
    assert !(test_g.contains("a"))
    test_g.add_node("a")
    assert (test_g.contains("a"))
  end

#==============================================================================#
  #bin_tree tests

  #Ensure that object attributes are correct
  def test_attrs
    #test BinTree attr
    tree = BinTree.new
    test_val = tree.root
    assert test_val == nil

    #test Node value
    test_node = Node.new(18)
    test_val = test_node.value
    assert_equal(test_val, 18)

    #test Node left set value and read value
    test_left = Node.new(1)
    test_node.left = test_left
    assert_equal(test_left, test_node.left)

    #test Node right set value and read value
    test_right = Node.new(23)
    test_node.right = test_right
    assert_equal(test_right, test_node.right)
  end

  #Ensure that the add method works correctly
  def test_add
    tree = BinTree.new
    #test empty
    assert tree.root == nil

    test_node =  Node.new(6)
    tree.add(test_node)
    #test one node added
    assert_equal(tree.root, test_node)

    test_node =  Node.new(4)
    tree.add(test_node)
    #test 2 nodes added
    assert_equal(test_node, tree.root.left)

    test_node =  Node.new(9)
    tree.add(test_node)
    #test 3 nodes added
    assert_equal(test_node, tree.root.right)

    test_node =  Node.new(-1)
    tree.add(test_node)
    #test 4 nodes added
    assert_equal(test_node, tree.root.left.left)
  end

  def test_contains
    tree = BinTree.new
    #test that nodes not in tree return false when tree is empty
    assert !(tree.contains(tree.root, Node.new(8)))

    #add various nodes to the tree
    tree.add(Node.new(8))
    tree.add(Node.new(1))
    tree.add(Node.new(4))
    tree.add(Node.new(17))
    tree.add(Node.new(-3))

    #test that these nodes on different paths return true for contains
    assert tree.contains(tree.root, Node.new(8))
    assert tree.contains(tree.root, Node.new(17))
    assert tree.contains(tree.root, Node.new(-3))

    #test that these node that aren't in the tree return false
    #tests on value
    assert !(tree.contains(tree.root, Node.new(99)))
    assert !(tree.contains(tree.root, Node.new(0)))

  end

  #test finding the lowest common ancestor
  def test_lca
    #build the following tree
    tree = BinTree.new
    tree.add(Node.new(8))    # =>      8
    tree.add(Node.new(1))    # =>    /   \
    tree.add(Node.new(4))    # =>   1     17
    tree.add(Node.new(17))   # =>  / \
    tree.add(Node.new(-3))   # =>-3   4

    #test lca for two child nodes of root is root
    x = tree.lowest_com_ancestor(Node.new(17), Node.new(1))
    assert_equal(8, x.value)

    #test one node being the parent of the other returns the parent
    x = tree.lowest_com_ancestor(Node.new(4), Node.new(1))
    assert_equal(1, x.value)

    #test far sides of tree return root
    x = tree.lowest_com_ancestor(Node.new(-3), Node.new(17))
    assert_equal(8, x.value)

    #test negative value works normally
    x = tree.lowest_com_ancestor(Node.new(4), Node.new(-3))
    assert_equal(1, x.value)

    #test that if both nodes are the same, returns that node
    x = tree.lowest_com_ancestor(Node.new(17), Node.new(17))
    assert_equal(17, x.value)

    #test negative with root itself returns root
    x = tree.lowest_com_ancestor(Node.new(-3), Node.new(8))
    assert_equal(8, x.value)

    #test node not in tree
    x = tree.lowest_com_ancestor(Node.new(-7), Node.new(8))
    assert x == nil

    #test nil node
    x = tree.lowest_com_ancestor(nil, Node.new(-3))
    assert x == nil
  end

end
