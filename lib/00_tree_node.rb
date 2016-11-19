class PolyTreeNode
  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  #attr_accessor

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end


  def parent=(par_node)
    if par_node
      if @parent
        @parent.children.delete(self)
      end
      @parent = par_node
      @parent.children << self
    else
      if @parent
        @parent.children.delete(self)
        @parent = nil
      end
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Error" unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    @children.each do |child|
      temp = child.dfs(target)
      return temp if temp
    end
    nil
  end

  def bfs(target)
    queue = []
    queue << self
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      current_node.children.each {|child| queue << child }
    end
  end
end
