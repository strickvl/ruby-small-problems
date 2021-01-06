class SecretHandshake
  def initialize(input)
    @input = convert_input(input)
    @commands = []
    process_input
  end

  def commands
    @commands
  end

  private

  def process_input
    reverse = 0
    if @input.size == 5
      reverse = 1
      @input = @input[1..-1]
    end

    index_counter = @input.size - 1

    until index_counter < 0
      char = @input[index_counter]
      if char == "1" && index_counter == 0
        @commands << "jump"
      elsif char == "1" && index_counter == 1
        @commands << "close your eyes"
      elsif char == "1" && index_counter == 2
        @commands << "double blink"
      elsif char == "1" && index_counter == 3
        @commands << "wink"
      end

      index_counter -= 1
    end

    @commands.reverse! if reverse == 1
  end

  def convert_input(value)
    if value.to_i == value
      return add_zeros(value.to_s(2))
    else
      return add_zeros(value)
    end
  end

  def add_zeros(string)
    if string.size < 4
      missing_zeros = "0" * (4-string.size)
      return missing_zeros+string
    else
      return string
    end
  end
end
