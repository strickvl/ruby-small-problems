class Card
  include Comparable
  attr_reader :rank, :suit

  POINTS = { 1 => 1,
            2 => 2,
            3 => 3,
            4 => 4,
            5 => 5,
            6 => 6,
            7 => 7,
            8 => 8,
            9 => 9,
            10 => 10,
            "Jack" => 11,
            "Queen" => 12,
            "King" => 13,
            "Ace" => 14
          }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    POINTS[rank] <=> POINTS[other.rank]
  end

  def score
    POINTS[rank]
  end
end

class Deck
  attr_reader :hand
  
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @hand = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @hand << Card.new(rank, suit)
      end
    end
    @hand.shuffle!
  end
  
  def draw
    initialize if @hand.empty?
    @hand.pop
  end
end

class PokerHand
  def initialize(deck)
    @deck = deck
    @hand = []
    5.times { @hand << @deck.draw }
  end

  def print
    @hand.each { |card| puts card }
  end

  def evaluate
    calculate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def hand_suits
    array = []
    @hand.each { |card| array << card.suit }
    array
  end

  def hand_values
    array = []
    @hand.each { |card| array << card.rank.to_s }
    array.sort
  end

  def hand_scores
    array = []
    @hand.each { |card| array << card.score }
    array.sort
  end

  def calculate
    @suit_counts = {}
    @rank_counts = {}
    Deck::RANKS.each do |rank|
      @rank_counts[rank] = 0
    end
    Deck::SUITS.each do |suit|
      @suit_counts[suit] = 0
    end
    @hand.each do |card|
      @suit_counts[card.suit] += 1
      @rank_counts[card.rank] += 1
    end
  end

  def royal_flush?
    rf_row = (hand_values == ["10", "Ace", "Jack", "King", "Queen"])
    flush? && rf_row
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    four = @rank_counts.any? {|_,v| v == 4}
    (@rank_counts.select {|_,v| v == 1 }).size == 1 && four
  end

  def full_house?
    three = @rank_counts.any? {|_,v| v == 3}
    two = @rank_counts.any? {|_,v| v == 2}
    three && two
  end

  def flush?
    @suit_counts.any? {|_,v| v == 5}
  end

  def straight?
    min = hand_scores.min
    hand_scores == [min, min+1, min+2, min+3, min+4]
  end

  def three_of_a_kind?
    three = @rank_counts.any? {|_,v| v == 3}
    (@rank_counts.select {|_,v| v == 1 }).size == 2 && three
  end

  def two_pair?
    two = @rank_counts.select {|_,v| v == 2}.count == 2
    (@rank_counts.select {|_,v| v == 1 }).size == 1 && two
  end

  def pair?
    two = @rank_counts.any? {|_,v| v == 2}
    (@rank_counts.select {|_,v| v == 1 }).size == 3 && two
  end
end


hand = PokerHand.new(Deck.new)
hand.print

puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'


hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
