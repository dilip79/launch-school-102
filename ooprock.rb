require 'pry'
class Player
  
  attr_accessor  :move, :player_name
  def initialize
    set_name
  end
end

class Human < Player

  
  def set_name
      name = ''
      loop do
        puts "what's your name?"
        name = gets.chomp
        break unless name.empty?
        puts "You must enter your name"
      end
      self.player_name = name
  end
  
  def choose
      choice = ''
      loop do
        puts "Choose among rock,paper, scissors"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts "It's not a valid choice"
      end
        self.move = choice
  end
  
end

class Computer < Player

  
  def set_name
    
    self.player_name = ['sun24', 'ibm43', 'unix14'].sample
   
  end
  
  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
  
  
end



class RPSGame
  
  attr_accessor :human, :computer
  
  def initialize()
    
    @human = Human.new
    @computer = Computer.new
    
    
  end
  
  def display_welcome_message
    puts "welcome to Rock, Paper, Scissors game "
  end
  
  def display_gooodbye_message
    puts " Thanks for playing Rock,Paper,Scissors game.Goodbye!"
  end
  
  def display_winner
    
    puts "#{human.name} choose #{human.move}"
    puts "#{computer.name} choose #{computer.move}"
    case human.move
    when 'rock'
      puts "It's a tie" if computer.move == 'rock'
      puts "Player won" if computer.move == 'paper'
      puts "Computer won" if computer.move == 'scissors'
    when 'paper'
      puts "It's a tie" if computer.move == 'paper'
      puts "Player won" if computer.move == 'scissors'
      puts "Computer won" if computer.move == 'rock'
    when 'scissors'
      puts "It's a tie" if computer.move == 'scissors'
      puts "Player won" if computer.move == 'rock'
      puts "Computer won" if computer.move == 'paper'
    end
    
  end
  
  
  
  def  play 
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      puts "want to play again? (y/n)"
      answer = gets.chomp
      break unless answer.downcase.include?('y')
    end
    display_gooodbye_message
  end
  
end

RPSGame.new.play
