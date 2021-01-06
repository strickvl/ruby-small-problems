SLICES_PER_PIZZA = 8
people = nil
pizzas = nil

loop do
  print "How many people? "
  people = gets.chomp
  break if people.to_i.to_s == people
  puts "Please enter a valid input."
end

loop do
  print "How many pizzas do you have? "
  pizzas = gets.chomp
  break if pizzas.to_i.to_s == pizzas
  puts "Please enter a valid input."
end

people = people.to_i
pizzas = pizzas.to_i

total_slices = SLICES_PER_PIZZA * pizzas

pieces, leftovers = total_slices.divmod(people)

people > 1 ? people_unit = "people" : people_unit = "person"
pieces > 1 ? pieces_unit = "pieces" : pieces_unit = "piece"

puts <<-MSG
#{people} #{people_unit} with #{pizzas} pizzas
Each person gets #{pieces} #{pieces_unit} of pizza.
MSG

if leftovers == 1
  puts "There is 1 leftover piece."
else
  puts "There are #{leftovers} leftover pieces."
end
