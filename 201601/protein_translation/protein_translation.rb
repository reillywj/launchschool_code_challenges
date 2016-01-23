require 'pry'

# Translation translates strands of codons from letter-form to polypeptide names
class Translation
  POLY = { methionine: %w(AUG),
           phenylalanine: %w(UUU UUC),
           leucine: %w(UUA UUG ),
           serine: %w(UCU UCC UCA UCG),
           tyrosine: %w(UAU UAC),
           cysteine: %w(UGU UGC),
           tryptophan: %w(UGG),
           stop: %w(UAA UAG UGA) }

  # Translation::InvalidCodonError for use when codon doesn't exist in POLY
  class InvalidCodonError < StandardError
    def initialize
    end
  end

  def self.of_codon(rna)
    values = POLY.select { |_, value| value.include?(rna) }.keys
    if values.empty?
      fail InvalidCodonError
    else
      value = values.first.to_s
      value == 'stop' ? value.upcase : value.capitalize
    end
  end

  def self.of_rna(strand)
    arr = []
    until strand.length <= 0
      codon = of_codon strand.slice!(0, 3)
      codon == 'STOP' ? break : arr << codon
    end
    arr
  end
end
