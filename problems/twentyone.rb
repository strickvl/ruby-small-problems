class Participant
  attr_accessor :hand, :tournament_score
  attr_reader :total

  def initialize
    @tournament_score = 0
    @hand = []
  end

  def total
    values = @hand.map(&:value)
    sum = 0
    values.each do |value|
      if value == "A"
        sum += 11
      elsif value.to_i == 0 # J, Q, K
        sum += 10
      else
        sum += value.to_i
      end
    end

    # correct for Aces
    values.select { |value| value == "A" }.count.times do
      sum -= 10 if sum > Game::GAME_TARGET
    end

    sum
  end

  def joinor(hand, delimiter=', ', word='and')
    case hand.size
    when 0 then ''
    when 1 then hand.first
    when 2 then hand.join(" #{word} ")
    else
      hand[-1] = "#{word} #{hand.last}"
      hand.join(delimiter)
    end
  end

  def busted?
    total > Game::GAME_TARGET
  end
end

class Player < Participant
  def show_cards
    cards = []
    @hand.each do |hand_card|
      cards << Deck::CARDS_NAMES[hand_card.value]
    end
    joinor(cards)
  end
end

class Dealer < Participant
  def show_cards_hidden
    cards = []
    cards << Deck::CARDS_NAMES[@hand.sample.value]
    remaining_card_count = @hand.size - 1
    remaining_card_count.times do
      cards << "hidden card"
    end
    joinor(cards)
  end

  def show_cards_open
    cards = []
    @hand.each do |hand_card|
      cards << Deck::CARDS_NAMES[hand_card.value]
    end
    joinor(cards)
  end
end

class Deck
  CARDS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITS = %w(H C D S)
  CARDS_NAMES = {
    "A" => "Ace",
    "2" => "2",
    "3" => "3",
    "4" => "4",
    "5" => "5",
    "6" => "6",
    "7" => "7",
    "8" => "8",
    "9" => "9",
    "10" => "10",
    "J" => "Jack",
    "Q" => "Queen",
    "K" => "King"
  }

  attr_accessor :cards

  def initialize
    @cards = SUITS.each_with_object([]) do |suit, array|
      CARDS.each do |card|
        array << Card.new(suit, card)
      end
    end
  end
end

class Card
  attr_reader :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end

class Game
  GAME_TARGET = 21
  INITIAL_CARD_COUNT = 2
  TOURNAMENT_END = 3

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    clear_screen
    tournament_game
  end

  private

  def play_round
    initial_deal
    show_all_cards
    player_turn
    dealer_turn
    show_result
  end

  def tournament_game
    tournament_reset
    until tournament_winner?
      tournament_welcome
      round_reset
      play_round
      calculate_winner
      wait_between_rounds
    end
    tournament_end
  end

  # rubocop:disable Metrics/LineLength
  def tournament_welcome
    clear_screen
    puts "========================================"
    puts "Welcome to Twenty-One!".center(40)
    puts "========================================"
    puts "Current Tournament Score: P:#{@player.tournament_score} D:#{@dealer.tournament_score}".center(40)
    puts "----------------------------------------"
  end
  # rubocop:enable Metrics/LineLength

  def tournament_end
    puts "Thanks for playing twenty-one!"
  end

  def tournament_reset
    @player.tournament_score = 0
    @dealer.tournament_score = 0
  end

  def round_reset
    @player.hand = []
    @dealer.hand = []
    @deck = Deck.new
  end

  def clear_screen
    system('cls') || system('clear')
  end

  def deal(participant)
    INITIAL_CARD_COUNT.times do
      card = @deck.cards.sample
      participant.hand << card
      @deck.cards.delete(card)
    end
  end

  def initial_deal
    deal(@player)
    deal(@dealer)
  end

  def someone_busted?
    @player.busted? || @dealer.busted?
  end

  def show_all_cards
    puts "Dealer has: #{@dealer.show_cards_hidden}"
    puts "You have: #{@player.show_cards}"
  end

  def show_all_cards_dealer_turn
    puts "Dealer has: #{@dealer.show_cards_open}"
    puts "You have: #{@player.show_cards}"
  end

  def calculate_winner
    if dealer_win_condition
      puts "The dealer won!"
      @dealer.tournament_score += 1
    elsif tie_condition
      puts "It's a tie!"
    elsif player_win_condition
      puts "You won!"
      @player.tournament_score += 1
    end
  end

  def dealer_win_condition
    (@dealer.total > @player.total && !@dealer.busted?) || @player.busted?
  end

  def tie_condition
    @dealer.total == @player.total
  end

  def player_win_condition
    (@player.total > @dealer.total && !@player.busted?) || @dealer.busted?
  end

  def wait_between_rounds
    puts "Starting new game in 5..."
    Kernel.sleep(1)
    puts "Starting new game in 4..."
    Kernel.sleep(1)
    puts "Starting new game in 3..."
    Kernel.sleep(1)
    puts "Starting new game in 2..."
    Kernel.sleep(1)
    puts "Starting new game in 1..."
    Kernel.sleep(1)
  end

  def tournament_winner?
    @player.tournament_score == TOURNAMENT_END || @dealer.tournament_score == TOURNAMENT_END
  end

  def hit(participant)
    card = @deck.cards.sample
    participant.hand << card
    @deck.cards.delete(card)
  end

  def player_turn
    choice = ""
    while @player.total <= 21
      loop do
        puts "Hit or stay? (h or s)"
        choice = gets.chomp.downcase
        case choice
        when "h"
          hit(@player)
          if someone_busted?
            puts "The player busted!"
            break
          end
          show_all_cards
          next
        when "s"
          puts "You stayed. Dealer turn begins now."
        end
        break if ["h", "s"].include?(choice)
        puts "Please try again. Choose between 'h' or 's'."
      end
      break
    end
  end

  def dealer_turn
    # hit until the total is greater than 17
    # when it reaches that point, stop and break out into the main method
    if @dealer.total >= 17
      puts "The dealer is staying."
    end
    until @dealer.total >= 17
      puts "The dealer is hitting now..."
      hit(@dealer)
      show_all_cards_dealer_turn
      puts "-------------"
      if @dealer.busted?
        puts "The dealer busted!"
        break
      end
    end
  end

  def show_result
    puts "Dealer score: #{@dealer.total}"
    puts "Player score: #{@player.total}"
  end
end

Game.new.start
