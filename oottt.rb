
require 'pry'
class Board
  
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new}
  end
  
  def get_square_at(key)
    @squares[key]
  end
  
  def []=(key,marker)
    @squares[key].marker =marker
  end
  
  def unmarked_keys
    @squares.select { |_,sq| sq.unmarked? }.keys
  end
  
  def full?
    unmarked_keys.empty?
  end
  
  def someone_wins?
    !!detect_winning_marker
  end
  
  def detect_winning_marker
   # WINNING_LINES.each do |line|
   #  if @squares.values_at(*line).collect(&:marker).count(TTTGame::HUMAN_MARKER) == 3
   #     return TTTGame::HUMAN_MARKER
   #   elsif @squares.values_at(*line).collect(&:marker).count(TTTGame::COMPUTER_MARKER) == 3 
   #     return TTTGame::COMPUTER_MARKER
   #   end
   # end
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers(squares)
        return squares.first.marker
      end
    end
    nil
  end
  
  
  
  def draw
    
    puts "     |     |"
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}  "
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}  "
    puts "     |     |"
    
  end
  
  private
  
  def three_identical_markers(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
  
end

class Square
  attr_accessor :marker
  INITIAL_MARKER = ' '
  
  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end
  
  def unmarked?
    @marker == INITIAL_MARKER
  end
  
  def marked?
    @marker != INITIAL_MARKER
  end
  
  def to_s
    @marker
  end
  
end

class Player
  
  attr_reader :marker
  def initialize(marker)
    @marker = marker
  end

end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_accessor :board, :human, :computer
  
  def initialize
    @board = Board.new
    @human = Player.new("X")
    @computer = Player.new("O") 
    
  end
  
  def play
    display_welcome_message
    loop do
      display_board
      loop do
        human_move
        break if board.someone_wins? || board.full?
        computer_move
        display_board
        break if board.someone_wins? || board.full?
      end
      
      display_winner
      break unless play_again?
      reset
    end
    display_gooodbye_message
  end
  
  private
  
  def display_board
    
    puts "You're #{human.marker} Computer is #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end
  
  def display_welcome_message
    puts "welcome to TicTacToe Game"
    
  end
  
  def display_gooodbye_message
    puts "Thanks for playing TicTacToe game. Goodbye!"
  end
  
  def human_move
    puts "Choose a choice in #{board.unmarked_keys}"
    square =''
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry that's not a valid choice!"
    end
    board.[]=(square,human.marker)
  end
  
  def computer_move
    board.[]=(board.unmarked_keys.sample, computer.marker)
  end
  
  def display_winner
    case board.detect_winning_marker
    when human.marker
      puts "You won"
    when computer.marker
      puts "computer won"
    else
      puts "It's a Tie"
    end
  end
  
  def play_again?
    puts "Do you want to play again? (press Y/N)"
    answer = gets.chomp
    #@board = Board.new 
    answer.downcase.start_with?('y')
  end
  
  def reset
    @board = Board.new
    system 'clear'
    puts "Let's play again"
    puts ""
  end
    
  
  
end

game = TTTGame.new
game.play

