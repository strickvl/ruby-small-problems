class GuessingGame
  GUESSES = 7
  LOW_LIMIT = 1
  HIGH_LIMIT = 100
  
  def initialize
    @choices = []
    LOW_LIMIT.upto(HIGH_LIMIT) do |num|
      @choices << num
    end
    @secret_number = @choices.sample
    @remaining_guesses = GUESSES
    @winner = "Computer"
    @choice = nil
  end

  def play
    reset
    clear_screen
    until @remaining_guesses == 0 || @winner == "Player"
      remaining_guesses
      take_input
      process_input
    end
    puts winner
  end

  private

  def remaining_guesses
    case @remaining_guesses
    when 1 then puts "You have one guess remaining."
    else
      puts "You have #{@remaining_guesses} guesses remaining."
    end
  end

  def clear_screen
    system('cls') || system('clear')
  end

  def take_input
    puts "Enter a number between #{LOW_LIMIT} and #{HIGH_LIMIT}:"
    loop do
      @choice = gets.chomp.to_i
      @remaining_guesses -=1
      break if (LOW_LIMIT..HIGH_LIMIT).include?(@choice)
      puts "Please enter a valid choice."
    end
  end

  def process_input
    if @choice == @secret_number
      @winner = "Player"
    elsif @choice < @secret_number
      puts "Your guess is too low."
    elsif @choice > @secret_number
      puts "Your guess is too high."
    end
  end

  def winner
    case @winner
    when "Computer" then "You have no more guesses. You lost!"
    else
      "You won!"
    end
  end

  def reset
    initialize
  end
end

game = GuessingGame.new
game.play
game.play
