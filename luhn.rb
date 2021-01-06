class Luhn
  def initialize(int)
    @input = int
  end

  def addends
    output = @input.digits
    index = 1
    until index >= output.size
      if output[index] < 5
        output[index] *= 2
      else
        output[index] = (output[index] * 2) - 9
      end
      index += 2
    end
    output.reverse
  end

  def checksum
    Luhn.new(@input).addends.sum
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(input)
    new_number = input
    counter = 0
    until Luhn.new(new_number).valid?
      new_number = input.digits.unshift(counter).reverse.join("").to_i
      counter += 1
    end
    new_number
  end
end
