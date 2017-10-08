require_relative 'bin_tree.rb'
require_relative 'node.rb'
require 'test/unit'

class TestBinTree < Test::Unit::TestCase
  #Ensure that the add method works correctly
  def test_add
    tree = BinTree.new
    #test empty
    assert_equal(tree.root, nil)

    test_node =  Node.new("A", 6,)
    tree.add(test_node)
    #test one node added
    assert_equal(tree.root, test_node)

    test_node =  Node.new("B", 4,)
    tree.add(test_node)
    #test 2 nodes added
    assert_equal(test_node, tree.root.left)

    test_node =  Node.new("C", 9,)
    tree.add(test_node)
    #test 3 nodes added
    assert_equal(test_node, tree.root.right)

    test_node =  Node.new("D", -1,)
    tree.add(test_node)
    #test 34 nodes added
    assert_equal(test_node, tree.root.left.left)
  end

  def test_contains
    tree = BinTree.new
    assert_false(tree.contains(tree.root, Node.new("a", 8)))

    tree.add(Node.new("a", 8))
    tree.add(Node.new("b", 1))
    tree.add(Node.new("c", 4))
    tree.add(Node.new("d", 17))
    tree.add(Node.new("f", -3))

    assert_true(tree.contains(tree.root, Node.new("a", 8)))
    assert_true(tree.contains(tree.root, Node.new("d", 17)))
    assert_true(tree.contains(tree.root, Node.new("f", -3)))

    assert_false(tree.contains(tree.root, Node.new("a", 99)))

  end

  def test_lca
    tree = BinTree.new
    tree.add(Node.new("a", 8))    # =>      a
    tree.add(Node.new("b", 1))    # =>    /   \
    tree.add(Node.new("c", 4))    # =>   b     d
    tree.add(Node.new("d", 17))   # =>  / \
    tree.add(Node.new("f", -3))   # => f   c

    x = tree.lowest_com_ancestor(Node.new("c", 4), Node.new("b", 1))
    assert_equal("b", x.key)

    x = tree.lowest_com_ancestor(Node.new("f", -3), Node.new("d", 17))
    assert_equal("a", x.key)

    x = tree.lowest_com_ancestor(Node.new("c", 4), Node.new("f", -3))
    assert_equal("b", x.key)

    x = tree.lowest_com_ancestor(Node.new("d", 17), Node.new("d", 17))
    assert_equal("d", x.key)
  end

end
