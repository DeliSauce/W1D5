require_relative "00_tree_node"

class KnightPathFinder
  VALID_MOVES = [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]]
  TOTAL_POSITIONS = 12 #Need to calculate this in the future based on board dimensions
  BOARD_DIM = 8

  attr_accessor :visited_positions

  def self.valid_moves(pos)
    row, col = pos
    mapped_moves = []
    VALID_MOVES.each do |move|
      mapped_moves << [move.first+row, move.last+col]
    end
    mapped_moves.select { |move| move.first >= 0 && move.first < BOARD_DIM && move.last >= 0 && move.last < BOARD_DIM}
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
    new_moves.each {|move| @visited_positions << move }
    #self.valid_moves
    #valid_moves
    new_moves
  end

  def build_move_tree
    queue = []
    queue << @root_node
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

knight = KnightPathFinder.new([0,0])
p knight.new_move_positions([0,0])
p knight.visited_positions
