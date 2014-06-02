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
    puts "target not found in #{ self.value }"
  end
end

class KnightPathFinder (position)
  attr_reader :position

  def initialize (position = [0,0])
    @position = position
    @remaining_moves = []
    (0..7).each do |x_coord|
      (0..7).each do |y_coord|
        @remaining_moves<<[x_coord, y_coord]
      end
    end

    @move_tree = self.build_move_tree(@position)
  end


  def find_path(destination)
    # use the move tree to find the "next child"
    # use DFS or BFS to search the move tree
    @move_tree.
  end

  def build_move_tree(pos)
    while !@remaining_moves.empty?
      orig_pos =|| TreeNode.new(pos, nil, []) #root
      KnightPathFinder.new_move_positions(pos).each do |move|
        TreeNode.new(move, parent = self).new_move_positions(move).each do |move|
          self.add_child(TreeNode.new(move, parent = self)) if @remaining_moves.include?(move)
          @remaining_moves.delete(move)
        end
      end
    end
    orig_pos
    #this will return a TreeNode object
  end

  def self.new_move_positions(pos)
    new_pos1 = [pos[0]+1, pos[1]+2]
    new_pos2 = [pos[0]+1, pos[1]-2]
    new_pos3 = [pos[0]-1, pos[1]+2]
    new_pos4 = [pos[0]-1, pos[1]-2]
    new_pos5 = [pos[0]+2, pos[1]+1]
    new_pos6 = [pos[0]+2, pos[1]-1]
    new_pos7 = [pos[0]-2, pos[1]+1]
    new_pos8 = [pos[0]-2, pos[1]-1]

    all_moves = [new_pos1, new_pos2, new_pos3, new_pos4,
      new_pos5, new_pos6, new_pos7, new_pos8]

    all_moves.select {|array| array[0]>0 && array[0]<8 && array[1]>0 && array[1]<8}
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