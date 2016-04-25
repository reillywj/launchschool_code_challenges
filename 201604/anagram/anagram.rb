require 'pry'

class Breakdown
  attr_reader :breakdown, :word

  def initialize(word)
    @word = word.downcase
    breakdown_word
  end

  def ==(other)
    @breakdown == other.breakdown
  end

  private

  def breakdown_word
    @breakdown = {}
    @word.chars.each do |char|
      @breakdown[char] = 0 unless @breakdown[char]
      @breakdown[char] += 1
    end
  end
end

class Anagram
  def initialize(word)
    @breakdown = Breakdown.new(word)
  end

  def match(words)
    matches = []
    words.each do |word|
      breakdown = Breakdown.new(word)
      matches << word if valid_anagram?(word)
    end
    matches
  end

  private

  def valid_anagram?(word)
    Breakdown.new(word) == @breakdown && word.downcase != word()
  end

  def word
    @breakdown.word
  end
end

