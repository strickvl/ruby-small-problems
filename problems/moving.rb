module Walkable
  def walk
    if self.class == Noble
      "#{title} #{name} #{gait} forward" if self.class == Noble
    else
      "#{name} #{gait} forward"
    end
  end
end

class Person
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  include Walkable
  
  def initialize(name, title)
    @name = name
    @title = title
  end

  attr_reader :name, :title

  private

  def gait
    "struts"
  end
end

mike = Person.new("Mike")
puts mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
puts kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
puts flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
puts byron.walk
# => "Lord Byron struts forward"

=begin
puts byron.name
# => "Byron"
puts byron.title
# => "Lord"
=end
