class Knight
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def possible_knight_moves
    possible_moves = []
    possible_moves << [@x + 1, @y + 2] << [@x - 1, @y + 2] <<
                      [@x + 2, @y + 1] << [@x + 2, @y - 1] << 
                      [@x - 2, @y + 1] << [@x - 2, @y - 1] <<
                      [@x + 1, @y - 2] << [@x - 1, @y - 2]
    possible_moves.map { |x| x if is_valid_move?(x) }.compact
  end

  def is_valid_move?(location)
    location[0] >= 0 && location[1] >= 0 && location[0] < 8 && location[1] < 8
  end

end

class Square
  attr_reader :x, :y, :parent, :children

  def initialize(x, y, parent = nil)
    @x = x
    @y = y
    @parent = parent
    @children = []
  end

  def create_children
    children = []
    children << [@x + 2, @y + 1] << [@x + 2, @y - 1] << 
                [@x - 2, @y + 1] << [@x - 2, @y - 1] <<
                [@x + 1, @y + 2] << [@x - 1, @y + 2] <<
                [@x + 1, @y - 2] << [@x - 1, @y - 2]
    children = children.select{ |child| is_valid_move?(child) }
    @children = children.map{ |child| Square.new(child[0], child[1], self) }
  end

  def knight_moves(from_location, to_location)
    result = get_final_square(from_location, to_location)

    route = []
    route.unshift([result.x, result.y])
    current = result.parent
    until current == nil
      route.unshift([current.x, current.y])
      current = current.parent
    end
    puts "You made it in #{route.length-1} move(s)! Here's your route:"
    route.each { |square| puts square.inspect }
    return nil
  end

  private

  def is_valid_move?(location)
    location[0] >= 0 && location[1] >= 0 && location[0] < 8 && location[1] < 8
  end

  def get_final_square(from_location, to_location)
    queue = []
    queue << Square.new(from_location[0], from_location[1])
    loop do
      current = queue.shift
      return current if current.x == to_location[0] && current.y == to_location[1]
      current.create_children.each { |child| queue << child }
    end
  end

end

s = Square.new(0, 0)
puts s.knight_moves([3,3],[4,3])
