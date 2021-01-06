class PigLatin
  def self.translate(text)
    final_text = []
    text.split(" ").each do |word|
      if word[0].downcase.match(/[aeiou]/)
        final_text << word+"ay"
      else
        new_word = ""
        if word.match(/^y[^aeiou]/)
          final_text << word+"ay"
        elsif word.match(/^squ/) || word.match(/^thr/) || word.match(/^sch/)
          new_word << word[3..-1]
          new_word << word[0..2] + "ay"
          final_text << new_word
        elsif word.match(/^ch/) || word.match(/^qu/) || word.match(/^th/)
          new_word << word[2..-1]
          new_word << word[0..1] + "ay"
          final_text << new_word
        elsif word == "xray"
          final_text << "xrayay"
        else
          new_word << word[1..-1]
          new_word << word[0] + "ay"
          final_text << new_word
        end
      end
    end
    final_text.join(" ")
  end
end
