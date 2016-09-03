require_relative 'poker'

class PokerHandType
  attr_reader :hi, :low, :type
  def initialize(type, low, hi)
    @type = type
    @low = Hand.new low
    @hi = Hand.new hi
  end

  def score_range
    [low.score, hi.score]
  end

  def to_s
    "#{type}: #{low.score} to #{hi.score}"
  end
end

hand_types = []

hand_types << PokerHandType.new("Hi Card", %w(2H 3D 4D 5D 7C), %w(AH KD QS JC 9S))
hand_types << PokerHandType.new("One Pair", %w(2H 2D 3D 4S 5C), %w(AH AD KS QC TD))
hand_types << PokerHandType.new("Two Pair", %w(2H 2D 3S 3D 4C), %w(AH AD KS KD QS))
hand_types << PokerHandType.new("Three of a Kind", %w(2H 2D 2C 3S 4D), %w(AH AD AC KS QH))
hand_types << PokerHandType.new("Straight", %w(2H 3H 4D 5C 6S), %w(TH JC QS KC AH))
hand_types << PokerHandType.new("Flush", %w(2S 3S 4S 5S 7S), %w(9S JS QS KS AS))
hand_types << PokerHandType.new("Full House", %w(2S 2D 2C 3S 3H), %w(KS KC AH AC AS))
hand_types << PokerHandType.new("Four of a Kind", %w(2S 2D 2C 2H 3D), %w(KC AC AD AH AS))
hand_types << PokerHandType.new("Straight Flush", %w(2D 3D 4D 5D 6D), %w(TS JS QS KS AS))

hand_types.each {|type| puts type}
