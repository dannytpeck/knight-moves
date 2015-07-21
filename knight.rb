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
  attr_accessor :location

  def initialize(location)
    @location = location
  end

  def knight_moves(from_location, to_location)
  end

end

class Chess
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    @board = []
    (0..8).each do |x|
      (0..8).each do |y|
        board.push([x, y])
      end
    end
    board
  end

end

game = Chess.new
print game.board
