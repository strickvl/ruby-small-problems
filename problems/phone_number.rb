class PhoneNumber
  INVALID = "0000000000"

  def initialize(input)
    @input = input
  end

  def number
    return "0000000000" if @input.match(/[A-Za-z]/)
    numbers = @input.scan(/\d/).join("")
    return numbers[1..-1] if numbers.size == 11 && numbers[0] == "1"
    return INVALID if numbers.size < 10 || numbers.size > 10
    numbers
  end

  def area_code
    number[0, 3]
  end

  def to_s
    "(#{area_code}) #{number[3, 3]}-#{number[6..-1]}"
  end
end
