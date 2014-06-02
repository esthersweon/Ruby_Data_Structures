#PHASE 1
module Search
  
  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      child.dfs(target)
    end
    puts "target not found"
  end

  def bfs(target)
    return self if self.value == target
    row_children = self.children

    until row_children.empty?
      child = row_children.pop
      return child if child.value == target
      row_children.unshift(*child.children)
    end

    # ^ BACKWARDS ON EACH ROW

    # until row_children.empty?
    #   child = row_children.shift
    #   return child if child.value == target
    #   row_children.push(*child.children)
    # end

    # ^ FORWARD ON EACH ROW

    puts "target not found in #{ self.value }"
  end
end

class TreeNode
  include Search
  attr_accessor :children, :value, :parent

  def initialize(value, parent = nil, children = [])
    @parent = parent
    @children = children
    @value = value
  end

  def remove_child(child_node)
    return "Not a child" if !child_node.is_a?(TreeNode)
    self.children.delete(child_node) # remove child_node from children array
    child_node.parent = nil
  end

  def add_child(child_node)
    return "Not a child" if !child_node.is_a?(TreeNode)
    child_node.parent.remove_child(child_node) if child_node.parent != nil

    child_node.parent = self
    self.children.push(child_node)
  end
end


a = TreeNode.new(5)
b = TreeNode.new(3)
c = TreeNode.new(1)
d = TreeNode.new(7)

a.add_child(b)
a.add_child(d)
b.add_child(c)
puts a.bfs(7).value.to_s

#     a
#    / \
#   b   d
#  /
# c








