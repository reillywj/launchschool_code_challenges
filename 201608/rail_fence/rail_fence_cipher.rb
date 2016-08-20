# RailFenceCipher for LaunchSchool Ruby Exercise
class RailFenceCipher
  def self.encode(str, cipher_size)
    create_encoder(str.split(''), cipher_size).map(&:join).join
  end

  def self.decode(str, cipher_size)
    decoder = create_encoder((0...str.size).to_a, cipher_size).flatten
    answer = []
    str.split('').each_with_index do |letter, i|
      answer[decoder[i]] = letter
    end
    answer.join
  end

  def self.create_encoder(arr, cipher_size)
    row = 0
    up = true
    encoder = Array.new(cipher_size) { [] }

    arr.each_with_index do |element, i|
      encoder[row][i] = element
      if row == cipher_size - 1
        up = false
      elsif row == 0
        up = true
      end

      row += up ? 1 : -1 if cipher_size > 1
    end
    encoder.map(&:compact)
  end
end
