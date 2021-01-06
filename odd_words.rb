## basic solution (at the word level)

class OddWords
  def initialize(string)
    @words = string.scan(/\w+/)
  end

  def convert
    @words.each_with_index do |word, index|
      word.reverse! if index.odd?
    end.join(" ") + "."
  end
end
