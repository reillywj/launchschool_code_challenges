require 'pry'

module CardInfo
  FACES = %w(2 3 4 5 6 7 8 9 T J Q K A).freeze

  def compare_faces(a, b)
    face_value(a) - face_value(b)
  end

  def max_face(arr_of_faces)
    arr_of_faces.sort{|a, b| compare_faces(a, b)}.last
  end

  def face_value(face)
    FACES.index(face)
  end
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

  def flush?
    cards.uniq{|card| card.suit}.length == 1
  end

  def straight?
    result = true
    @cards.sort.map{|card| face_value(card.face)}.each_cons(2) do |two_face_values|
      result &&= two_face_values.last - two_face_values.first == 1
    end
    result
  end

  def summarize_multiples
    Multiples.summarize(self)
  end

  def score
    summarize_multiples.score
  end

  def <=>(other_hand)
    score <=> other_hand.score
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

  def same_suit?(other_card)
    suit == other_card.suit
  end

  def <=>(other_card)
    compare_faces(face, other_card.face)
  end
end

class Multiples
  attr_reader :multiples, :high_single
  include CardInfo

  TYPE_SCORES = {high_card: 0, one_pair: 100, two_pair: 200, three_of_a_kind: 300, full_house: 600, four_of_a_kind: 700}

  def initialize
    @multiples = Hash[FACES.map{|face| [face, 0]}]
  end

  def self.summarize(hand)
    multiples = Multiples.new
    hand.cards.each do |card|
      multiples.add(card)
    end
    multiples.filter!
    multiples
  end

  def filter!
    singles = multiples.select{ |_k, v| v === 1 }.keys
    @high_single = max_face(singles)
    self.multiples.delete_if{ |_k, v| v <= 1 }
  end

  def add(card)
    multiples[card.face] += 1
  end

  def to_a
    multiples.to_a
  end

  def type
    if multiples.empty?
      :high_card
    elsif multiples.length == 1
      case multiples.values.first
      when 2 then :one_pair
      when 3 then :three_of_a_kind
      when 4 then :four_of_a_kind
      end
    else
      case multiples.values.max
      when 3 then :full_house
      else
        :two_pair
      end
    end
  end

  def score
    score = TYPE_SCORES[type]
    score += face_value(high_single) if high_single
  end
end






























