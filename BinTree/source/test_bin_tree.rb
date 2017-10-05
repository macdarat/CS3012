require_relative 'bin_tree.rb'
require_relative 'node.rb'
require 'test/unit'

class TestBinTree < Test::Unit::TestCase
  #Ensure that the add method works correctly
  def test_add
    tree = BinTree.new
    assert_equal(tree.root, nil)

    test_node =  Node.new("A", 6,)
    tree.add(tree.root, test_node)
    puts tree.root.key
    assert_equal(tree.root, test_node)
  end

  def test_contains

  end

  def test_delete

  end

  def test_lca

  end

end
