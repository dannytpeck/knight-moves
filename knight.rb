#knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
#knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
#knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

#1. Put together a script that creates a game board and a knight.
#2. Treat all possible moves the knight could make as children in 
#   a tree. Don't allow any moves to go off the board.
#3. Decide which search algorithm is best to use for this case. 
#   Hint: one of them could be a potentially infinite series.
#4. Use the chosen search algorithm to find the shortest path 
#   between the starting square (or node) and the ending square. 
#   Output what that full path looks like, e.g.:

#$ knight_moves([3,3],[4,3])
#You made it in 3 moves!  Here's your path:
#[3,3]
#[4,5]
#[2,4]
#[4,3]

class Knight
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def knight_moves(from_location, to_location)
    @x = from_location[0]
    @y = from_location[1]

    possible_moves = []

    possible_moves << [@x + 2, @y + 1] << [@x + 2, @y - 1] << 
                      [@x - 2, @y + 1] << [@x - 2, @y - 1] <<
                      [@x + 1, @y + 2] << [@x - 1, @y + 2] <<
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
    children = children.map{ |child| Square.new(child[0], child[1], self) }
    @children = children
  end

  def knight_moves(from_location, to_location)
    queue = []
    queue << Square.new(from_location[0], from_location[1])
    loop do
      current = queue.shift
      return current.info if from_location[0] == to_location[0] && from_location[1] == to_location[1]
      current.create_children.each { |child| queue << child }
    end
  end

  def info
    "Square Info: X = #{@x}; Y = #{@y}"
  end

  private

  def is_valid_move?(location)
    location[0] >= 0 && location[1] >= 0 && location[0] < 8 && location[1] < 8
  end

end

s = Square.new(0, 0)
s.knight_moves([0, 0],[2, 1])

#s.create_children.each do |child|
#  puts child.info
#end
