class WordProblem
  def initialize(string)
    @string = process(string)
  end

  def answer
    calculate(@string)
  end

  private

  def calculate(string)
    pieces = string.split
    raise ArgumentError if string.match(/[A-Za-z]+/)
    current = pieces.first.to_i
    final = 0
    index = 1
    loop do
      break if index >= pieces.size
      final = (current.send(pieces[index], pieces[index+1].to_i))
      index += 2
      current = final
    end
    final
  end
  
  def process(input)
    input.gsub!(/What is /, "")
    input.gsub!(/\splus\s/, " + ")
    input.gsub!(/\minus\s/, " - ")
    input.gsub!(/\smultiplied\sby/, " * ")
    input.gsub!(/\sdivided\sby\s/, " / ")
    input.gsub!(/\?/, "")
  end
end
