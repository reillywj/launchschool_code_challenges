require 'pry'
class Crypto
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def normalize_plaintext
    @normalize_plaintext ||= input.gsub(/[^A-z0-9]*[\^]*/, "").downcase.strip
  end

  def size
    @size ||= (normalize_plaintext.size**0.5).ceil
  end

  def plaintext_segments
    segments = []
    (size).times do |index|
      segment_size = index == 0 ? size : [size, normalize_plaintext.length - size].min
      segments << normalize_plaintext[index*size, segment_size]
    end
    segments.delete(nil)
    segments.delete("")
    segments
  end

  def ciphertext
    return @ciphertext if @ciphertext
    segment_chars = plaintext_segments.map(&:chars)
    cipher = []
    size.times do
      cipher << segment_chars.reduce([]) { |zip, chars| zip << chars.shift }
    end
    @ciphertext = cipher.flatten.join
  end

  def normalize_ciphertext
    min_length = ciphertext.size / size
    additional_length = ciphertext.size % size
    normalized_cipher = ciphertext
    location = 0
    size.times do |index|
      adder = additional_length > 0 ? 1 : 0
      location += adder + min_length
      normalized_cipher.insert(location, " ") unless index == size - 1
      location += 1
      additional_length -= 1 unless additional_length == 0
    end
    normalized_cipher
  end
end