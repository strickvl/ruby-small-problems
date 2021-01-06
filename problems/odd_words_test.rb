require 'minitest/autorun'
require_relative 'odd_words'

class OddWordsTest < Minitest::Test
  def test_basic_sentence
    correct = "whats eht matter htiw kansas."
    assert_equal(correct, OddWords.new("whats the matter with kansas.").convert)
  end

  def test_with_spaces
    correct = "whats eht matter htiw kansas."
    assert_equal(correct, OddWords.new("whats  the  matter  with  kansas.").convert)
  end

  def test_with_spaces_after_final_word
    correct = "whats eht matter htiw kansas."
    assert_equal(correct, OddWords.new("whats  the  matter  with  kansas    .").convert)
  end
end
