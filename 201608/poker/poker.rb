require 'pry'

module CardInfo
  FACES = %w(2 3 4 5 6 7 8 9 T J Q K A)
end

class Poker
  def initialize(hands)
    @hands = hands.map{ |hand| Hand.new hand }
  end

  def best_hand
    [@hands.sort.last.to_a]
  end
end

class Hand
  attr_reader :cards

  include Enumerable
  include CardInfo

  def initialize(cards)
    @cards = cards.map{ |card| Card.new card }
  end

  def to_a
    @cards.map(&:to_s)
  end

  def high_card
    cards.max
  end

  def summarize_multiples
    Multiples.summarize(hand)
  end

  def <=>(other_hand)
    high_card <=> other_hand.high_card
  end
end

class Card
  attr_reader :face, :suit

  include Enumerable
  include CardInfo

  def initialize(card)
    @face, @suit = card.split("")
  end

  def to_s
    "#{face}#{suit}"
  end

  def <=>(other_card)
    FACES.index(face) - FACES.index(other_card.face)
  end
end

class Multiples
  attr_reader :summary
  include Enumerable

  def initialize
    @summary = {}
  end

  def self.summarize(hand)
    summary = Multiples.new

    hand.cards.each do |card|
      summary.add(card)
    end

    summary
  end

  def add(card)
    summary[card.face] = 0 unless summary[card.face]
    summary[card.face] += 1
  end

  def <=>(other_multiples_hand)
    # compare hands solely based on multiples
    # will need to look up some hash methods to sort by count then compare cards, if counts are equal
  end
end
