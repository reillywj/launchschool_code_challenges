
class Phrase
  attr_reader :phrase

  def initialize(phrase)
    @phrase = phrase.gsub(/[^A-z0-9 \']/, ' ').gsub(/\^/,' ').gsub(/ \'|\' /,' ')
  end

  def word_count
    return @word_count if @word_count
    @word_count = {}
    phrase.split(' ').each do |word|
      word = word.downcase
      @word_count[word] = 0 unless @word_count[word]
      @word_count[word] += 1
    end
    @word_count
  end
end