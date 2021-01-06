require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonals

  ALMOST_MOVES = [
    [1, 2, 3],
    [2, 3, 1],
    [1, 3, 2],
    [4, 5, 6],
    [5, 6, 4],
    [4, 6, 5],
    [7, 8, 9],
    [8, 9, 7],
    [7, 9, 8],
    [1, 4, 7],
    [1, 7, 4],
    [2, 5, 8],
    [2, 8, 5],
    [3, 6, 9],
    [3, 9, 6],
    [4, 7, 1],
    [5, 8, 2],
    [6, 9, 3],
    [7, 5, 3],
    [3, 5, 7],
    [3, 7, 5],
    [1, 5, 9],
    [5, 9, 1],
    [1, 9, 5]
  ]

  def initialize
    @squares = {}
    reset
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      values = @squares.values_at(*line).collect(&:marker)
      if values[0] == values[1] && values[0] == values[2]
        winning_marker = values[0]
        return winning_marker if winning_marker != Square::INITIAL_MARKER
      end
    end
    nil
  end

  def somewhere_needs_defending?
    !!defensive_opportunity
  end

  def defensive_opportunity
    Board::ALMOST_MOVES.each do |line|
      values = @squares.values_at(*line).collect(&:marker)
      condition1 = values[2] == Square::INITIAL_MARKER
      condition2 = values[0] != Square::INITIAL_MARKER
      condition3 = values[0] == values[1]
      if condition1 && condition2 && condition3
        return line[2]
      end
    end
    nil
  end

  def somewhere_open_for_attack?
    !!offensive_opportunity
  end

  def offensive_opportunity
    Board::ALMOST_MOVES.each do |line|
      values = @squares.values_at(*line).collect(&:marker)
      computer_marker = TTTGame::COMPUTER_MARKER
      if values[0] == computer_marker && values[1] == computer_marker
        return line[2]
      end
    end
    nil
  end

  def middle_square_unclaimed?
    @squares[5].marker == Square::INITIAL_MARKER
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(num, marker)
    @squares[num].marker = marker
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :marker, :name

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def increment_score
    self.score += 1
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  ROUNDS = 2

  attr_accessor :current_player

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = nil
  end

  def play
    choose_player
    choose_marker
    name_players
    clear_screen
    display_welcome_message
    loop do
      while tournament_not_won?
        round_play
      end
      reset_tournament
      break unless play_again?
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def suitable_marker?(input)
    input.size == 1 && input != " "
  end

  def suitable_name?(input)
    input != "" && input != " "
  end

  def round_play
    display_board
    loop do
      current_player_moves_then_switch_player
      break if @board.someone_won? || @board.full?
      clear_screen_and_display_board if human_turn?
    end

    display_result_then_update_score
    tournament_not_won? ? pause_and_reset : declare_winner
  end

  def declare_winner
    clear_screen
    display_board
    puts "#{tournament_winner} won the tournament!"
  end

  def choose_player
    clear_screen
    loop do
      puts "Which user to start? (player(p) or computer(c) or random(r))?"
      choice = gets.chomp
      case choice.downcase
      when "p" then @current_player = @human
      when "c" then @current_player = @computer
      when "r" then @current_player = [@human, @computer].sample
      end
      break if [@computer, @human].include?(@current_player)
      puts "Invalid choice. Please choose again."
    end
    puts ""
  end

  def parse_and_state_marker_choice_error(choice)
    if choice == @computer.marker
      puts "Make another choice."
      puts "That option is reserved as the computer's marker."
    elsif choice.length > 1
      puts "That is too long. Please choose again."
    end
  end

  def choose_marker
    loop do
      puts "What would you like your marker to be? (press return for default)"
      puts "Marker can be one character long."
      marker_choice = gets.chomp
      marker_choice = HUMAN_MARKER if marker_choice == ""
      suitable = suitable_marker?(marker_choice)
      @human.marker = marker_choice if suitable
      parse_and_state_marker_choice_error(@human.marker)
      break if marker_choice != @computer.marker && suitable
    end
  end

  def name_players
    loop do
      name_human
      name_computer
      break if @human.name != @computer.name
      puts "The two names can't be the same. Please choose again."
    end
  end

  def name_human
    loop do
      puts "What is your name?"
      human_name = gets.chomp
      @human.name = human_name
      break if suitable_name?(human_name)
      puts "Invalid choice. Try again."
    end
  end

  def name_computer
    loop do
      puts "What would you like the computer to be called?"
      computer_name = gets.chomp
      @computer.name = computer_name
      break if suitable_name?(computer_name)
      puts "Invalid choice. Try again."
    end
  end

  def pause_and_reset
    puts "Starting new game in 3..."
    Kernel.sleep(1)
    puts "Starting new game in 2..."
    Kernel.sleep(1)
    puts "Starting new game in 1..."
    Kernel.sleep(1)
    reset
  end

  def tournament_winner
    if @human.score == ROUNDS
      "Player"
    elsif @computer.score == ROUNDS
      "Computer"
    end
  end

  def joinor(array, divider=",", word="or")
    string = ""
    initial_numbers = array.slice(0..-2)
    last_number = array.last
    initial_numbers.each do |num|
      string << "#{num}#{divider} "
    end
    string << "#{word} #{last_number}"
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
    puts "The game is scored best of #{ROUNDS} rounds."
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe!"
    puts "Goodbye!"
  end

  # rubocop:disable Metrics/LineLength
  def display_board
    puts "---------------------------"
    puts "Tournament Score ==> #{@human.name}: #{@human.score} - #{@computer.name}: #{@computer.score}"
    puts "---------------------------"
    puts "You're a #{@human.marker}. Computer is a #{@computer.marker}."
    puts ""
    @board.draw
    puts ""
  end
  # rubocop:enable Metrics/LineLength

  def human_turn?
    @current_player == @human
  end

  def human_moves
    puts "Choose a square (#{joinor(@board.unmarked_keys)}):"
    # puts "Choose a square (#{@board.unmarked_keys.join(', ')}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if @board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    @board[square] = @human.marker
  end

  def computer_moves
    computer_marker = @computer.marker
    if @board.somewhere_open_for_attack?
      @board[@board.offensive_opportunity] = computer_marker
    elsif @board.somewhere_needs_defending?
      @board[@board.defensive_opportunity] = computer_marker
    elsif @board.middle_square_unclaimed?
      @board[5] = computer_marker
    else
      @board[@board.unmarked_keys.sample] = computer_marker
    end
  end

  def current_player_moves_then_switch_player
    case @current_player
    when @human
      human_moves
      self.current_player = @computer
    when @computer
      computer_moves
      self.current_player = @human
    end
  end

  def display_result_then_update_score
    clear_screen_and_display_board
    case @board.winning_marker
    when @human.marker
      puts "You won!"
      @human.increment_score
    when @computer.marker
      puts "Computer won!"
      @computer.increment_score
    else
      puts "It's a tie!"
    end
  end

  def tournament_not_won?
    @human.score != ROUNDS && @computer.score != ROUNDS
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def reset
    @board.reset
    self.current_player = @human
    clear_screen
  end

  def reset_tournament
    @board.reset
    self.current_player = @human
    @human.score = 0
    @computer.score = 0
  end

  def display_play_again_message
    clear_screen
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
