class Pet
  attr_reader :animal_type, :name
  
  def initialize(animal_type, name)
    @animal_type = animal_type
    @name = name
  end

  def to_s
    "a #{animal_type} named #{name}"
  end
end

class Owner
  attr_reader :name
  attr_reader :number_of_pets
  
  def initialize(name)
    @name = name
    @number_of_pets = 0
  end

  def increment_pet
    @number_of_pets += 1
  end
end

class Shelter
  def initialize
    @shelter = {}
  end
  
  def adopt(owner, pet)
    @shelter[owner] = [] if @shelter[owner].nil?
    owner.increment_pet
    @shelter[owner] << pet
  end

  def print_adoptions
    @shelter.keys.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      @shelter[owner].each do |pet|
        puts pet
      end
      puts ""
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

=begin EXPECTED OUTPUT

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

=end
