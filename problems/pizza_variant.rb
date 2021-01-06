SLICES_PER_PIZZA = 8
people = nil
pieces = nil

loop do
  print "How many people? "
  people = gets.chomp
  break if people.to_i.to_s == people
  puts "Please enter a valid input."
end

loop do
  print "How many pieces should each person receive? "
  pieces = gets.chomp
  break if pieces.to_i.to_s == pieces
  puts "Please enter a valid input."
end

people = people.to_i
pieces = pieces.to_i

slices_needed = people * pieces
pizzas, remainder = slices_needed.divmod(SLICES_PER_PIZZA)
leftovers = 0

if remainder > 0
  pizzas = pizzas + 1
  leftovers = SLICES_PER_PIZZA - remainder
end

people > 1 ? people_unit = "people" : people_unit = "person"
pieces > 1 ? pieces_unit = "pieces" : pieces_unit = "piece"

puts <<-MSG
#{people} #{people_unit} needing #{pieces} #{pieces_unit} each.
Each person gets #{pieces} #{pieces_unit} of pizza.
MSG

if leftovers == 1
  puts "There is 1 leftover piece."
else
  puts "There are #{leftovers} leftover pieces."
end
