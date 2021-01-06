require 'pry'

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



deck = Deck.new
drawn = []
52.times { drawn << deck.draw }

puts drawn.count { |card| card.rank == 5 }# == 4
puts drawn.count { |card| card.suit == 'Hearts' }# == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.
