require_relative "00_tree_node"

class KnightPathFinder
  VALID_MOVES = [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]]
  BOARD_DIM = 8

  def self.valid_moves(pos)
    row, col = pos
    mapped_moves = []

    VALID_MOVES.each do |move|
      mapped_moves << [move.first + row, move.last + col]
    end

    mapped_moves.select do |move|
      move.first >= 0 &&
      move.first < BOARD_DIM &&
      move.last >= 0 &&
      move.last < BOARD_DIM
    end
  end

  def initialize(start_position)
    @visited_positions = [start_position]
    @root_node = PolyTreeNode.new(start_position)
    build_move_tree
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end
    new_moves.each { |move| @visited_positions << move }
  end

  def find_path(end_pos)
    #we're using dfs here but could also use bfs just the same
    end_node = @root_node.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(node)
    path = [node.value]
    next_node = node.parent
    while next_node
      path.unshift(next_node.value)
      next_node = next_node.parent
    end
    path
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      current_node = queue.shift

      #create children from parent
      new_move_positions(current_node.value).each do |child_pos|
        current_node.add_child(PolyTreeNode.new(child_pos))
      end

      #add children to queue
      current_node.children.each do |child_node|
        queue << child_node
      end
    end
  end

end

knight = KnightPathFinder.new([0, 0])
p knight.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 7], [7, 6]]
p knight.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 4], [4, 3], [6, 2]]
