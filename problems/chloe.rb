class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(name)
    @name = name
    # also recommended to replace line 9 is
    # self.name = name
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name
