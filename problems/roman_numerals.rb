class Integer
<<<<<<< HEAD
  CONVERSIONS = {
    1 => "I",
    5 => "V",
    10 => "X",
    50 => "L",
    100 => "C",
    500 => "D",
    1000 => "M"
  }

  def to_roman
    final = ""
    number = self.to_s
    number.chars.each do |char|
      final << CONVERSIONS[char.to_i]
=======
  def to_roman
    final = ""
    digits = self.to_s.chars.reverse
    order_level = digits.size
    digits.each_with_index do |digit, index|
      next if digit == "0"
      converted_digit = digit.to_i * 10 ** index
      unit = converted_digit.to_s[0].to_i
      converted_size = converted_digit.to_s.size
      case converted_size
      when 4
        final.prepend("M" * unit)
      when 3
        if unit < 4
          final.prepend("C" * unit)
        elsif unit == 4
          final.prepend("CD")
        elsif unit == 5
          final.prepend("D")
        elsif [6,7,8].include?(unit)
          final.prepend("D" + ("C" * (unit-5)))
        else
          final.prepend("CM")
        end
      when 2
        if unit < 4
          final.prepend("X" * unit)
        elsif unit == 4
          final.prepend("XL")
        elsif unit == 5
          final.prepend("L")
        elsif [6,7,8].include?(unit)
          final.prepend("L" + ("X" * (unit-5)))
        else
          final.prepend("XC")
        end
      when 1
        if unit < 4
          final.prepend("I" * unit)
        elsif unit == 4
          final.prepend("IV")
        elsif unit == 5
          final.prepend("V")
        elsif [6,7,8].include?(unit)
          final.prepend("V" + ("I" * (unit-5)))
        else
          final.prepend("IX")
        end
      end
>>>>>>> 898c106bed08b5a5a2bf3d6a9c4fcb0f0cc2658b
    end
    final
  end
end
<<<<<<< HEAD

p 1998.to_roman
=======
>>>>>>> 898c106bed08b5a5a2bf3d6a9c4fcb0f0cc2658b
