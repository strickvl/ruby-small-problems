class Anagram
  def initialize(word)
    @original_word = word
    @downcase_word = word.downcase
  end

  def match(array)
    downcase_chars = @downcase_word.chars.sort
    array.delete_if { |word| word.downcase == @original_word.downcase }
    array.select { |word| word.downcase.chars.sort == downcase_chars }
  end
end
