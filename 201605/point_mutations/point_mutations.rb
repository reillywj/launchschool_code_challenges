class DNA
  attr_reader :sequence
  def initialize(sequence)
    @sequence = sequence
  end

  def hamming_distance(other_sequence)
    distance = 0
    shortest(sequence, other_sequence).times do |index|
      distance += 1 unless sequence[index] == other_sequence[index]
    end
    distance
  end

  private

  def shortest(str1, str2)
    case str1.length <=> str2.length
    when -1
      str1.length
    else
      str2.length
    end
  end
end