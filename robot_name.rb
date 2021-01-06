USED_NAMES = []

class Robot
  attr_reader :name

  def initialize
    suggested_name = generate_name
    @name = suggested_name
    @name = generate_name if !USED_NAMES.include?(suggested_name)
  end

  def reset
    USED_NAMES.delete(name)
    initialize
  end

  private

  def generate_name
    numbers = format('%03d', Random.new.rand(0..999))
    letters = generate_name_letters
    name = letters + numbers
    USED_NAMES << name
    name
  end

  def generate_name_letters
    letters = []
    2.times do
      letters << Random.new.rand(65..90).chr
    end
    letters.join
  end
end
