require_relative 'bin_tree.rb'
require_relative 'node.rb'
require 'minitest/spec'
require 'minitest/autorun'

class TestBinTree < Minitest::Test

  #Ensure that object attributes are correct
  def test_attrs
    #test BinTree attr
    tree = BinTree.new
    test_val = tree.root
    assert test_val == nil

    #test Node key
    test_node = Node.new("M", 18)
    test_val = test_node.key
    assert_equal(test_val, "M")

    #test Node val
    test_val = test_node.value
    assert_equal(test_val, 18)

    #test Node left set value and read value
    test_left = Node.new("F", 1)
    test_node.left = test_left
    assert_equal(test_left, test_node.left)

    #test Node right set value and read value
    test_right = Node.new("Q", 23)
    test_node.right = test_right
    assert_equal(test_right, test_node.right)
  end

  #Ensure that the add method works correctly
  def test_add
    tree = BinTree.new
    #test empty
    assert tree.root == nil

    test_node =  Node.new("A", 6)
    tree.add(test_node)
    #test one node added
    assert_equal(tree.root, test_node)

    test_node =  Node.new("B", 4)
    tree.add(test_node)
    #test 2 nodes added
    assert_equal(test_node, tree.root.left)

    test_node =  Node.new("C", 9)
    tree.add(test_node)
    #test 3 nodes added
    assert_equal(test_node, tree.root.right)

    test_node =  Node.new("D", -1)
    tree.add(test_node)
    #test 4 nodes added
    assert_equal(test_node, tree.root.left.left)
  end

  def test_contains
    tree = BinTree.new
    #test that nodes not in tree return false when tree is empty
    assert !(tree.contains(tree.root, Node.new("a", 8)))

    #add various nodes to the tree
    tree.add(Node.new("a", 8))
    tree.add(Node.new("b", 1))
    tree.add(Node.new("c", 4))
    tree.add(Node.new("d", 17))
    tree.add(Node.new("f", -3))

    #test that these nodes on different paths return true for contains
    assert tree.contains(tree.root, Node.new("a", 8))
    assert tree.contains(tree.root, Node.new("d", 17))
    assert tree.contains(tree.root, Node.new("f", -3))

    #test that these node that aren't in the tree return false
    #tests on value
    assert !(tree.contains(tree.root, Node.new("a", 99)))
    assert !(tree.contains(tree.root, Node.new("b", 0)))

  end

  #test finding the lowest common ancestor
  def test_lca
    #build the following tree
    tree = BinTree.new
    tree.add(Node.new("a", 8))    # =>      a
    tree.add(Node.new("b", 1))    # =>    /   \
    tree.add(Node.new("c", 4))    # =>   b     d
    tree.add(Node.new("d", 17))   # =>  / \
    tree.add(Node.new("f", -3))   # => f   c

    #test lca for two child nodes of root is root
    x = tree.lowest_com_ancestor(Node.new("d", 17), Node.new("b", 1))
    assert_equal("a", x.key)

    #test one node being the parent of the other returns the parent
    x = tree.lowest_com_ancestor(Node.new("c", 4), Node.new("b", 1))
    assert_equal("b", x.key)

    #test far sides of tree return root
    x = tree.lowest_com_ancestor(Node.new("f", -3), Node.new("d", 17))
    assert_equal("a", x.key)

    #test negative value works normally
    x = tree.lowest_com_ancestor(Node.new("c", 4), Node.new("f", -3))
    assert_equal("b", x.key)

    #test that if both nodes are the same, returns that node
    x = tree.lowest_com_ancestor(Node.new("d", 17), Node.new("d", 17))
    assert_equal("d", x.key)

    #test negative with root itself returns root
    x = tree.lowest_com_ancestor(Node.new("f", -3), Node.new("a", 8))
    assert_equal("a", x.key)
  end

end
