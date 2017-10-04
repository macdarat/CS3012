#represents a node in a binary tree

class Node
  def initialize(key, value)
    @key = key
    @value = value
    @left = nil
    @right = nil
  end

  attr_reader :key
  attr_reader :value
  attr_reader :left
  attr_reader :right

end
