class Phrase
  def initialize(text)
    regex = /[^A-Za-z0-9']/
    @text = text.gsub(regex, " ").downcase.split
  end

  def word_count
    words = @text.uniq
    @hash = {}
    words.each do |word|
      @hash[word] = @text.count(word)
    end
    update_entries
    @hash
  end

  def update_entries
    @hash.keys.each do |key|
      if key.match(/['"]\w+['"]/)
        word = key.match(/['"](\w+)['"]/)[1]
        @hash[word] += @hash[key]
        @hash.delete(key)
      end
    end
  end
end
