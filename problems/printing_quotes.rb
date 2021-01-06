# FIRST SOLUTION

# puts "What is the quote?"
# quote = gets.chomp
# puts "Who said it?"
# author = gets.chomp
# puts "#{author} says, \"#{quote}.\""

# SECOND SOLUTION

# puts "What is the quote?"
# quote = gets.chomp
# puts "Who said it?"
# author = gets.chomp
# puts author + " says, \"" + quote + ".\""

# THIRD SOLUTION

class Game
  def initialize
    @quotes = []
  end

  def add
    puts "What is the quote?"
    quote = gets.chomp
    puts "Who said it?"
    author = gets.chomp
    @quotes << [author, quote]
  end

  def print_quotes
    puts "LIST OF QUOTES"
    puts "--------------"
    @quotes.each do |quote|
      puts quote[0] + " says, \"" + quote[1] + "\""
    end
    puts "--------------"
  end

  def greeting
    puts "Welcome to the Quote Explorer."
  end

  def play
    greeting
    loop do
      puts "What would you like to do? ((a)dd, (p)rint, (q)uit)"
      command = gets.chomp
      break if command.downcase == "q"
      add() if command.downcase == "a"
      print_quotes() if command.downcase == "p"
    end
    puts "Thank you for using our quote service."
  end
end

Game.new.play
