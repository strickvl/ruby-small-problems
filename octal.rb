class Octal
  def initialize(octal_value)
    @octal_value = octal_value
  end

  def to_decimal
    return 0 if @octal_value.match(/[89\D]/)
    digits = @octal_value.chars
    size = digits.size
    decimal_value = 0
    digits.each do |digit|
      decimal_value += digit.to_i * (8**(size - 1))
      size -= 1
    end
    decimal_value
  end
end
