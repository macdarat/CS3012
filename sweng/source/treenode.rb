#represents a node in a graph

class TreeNode
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  attr_reader :value
  attr_accessor :left
  attr_accessor :right

end
