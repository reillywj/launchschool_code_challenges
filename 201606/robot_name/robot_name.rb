class Robot
  LETTERS = ('A'..'Z').to_a.freeze
  
  class << self; attr_accessor :names end
  @names = []

  attr_reader :name

  def initialize
    generate_name(2, 3)
  end

  def reset
    old_name = name
    generate_name(@letters, @numbers)
    self.class.names.delete old_name
  end

  private

  def generate_name(letters, numbers)
    @letters ||= letters
    @numbers ||= numbers
    new_name = ''
    letters.times { new_name << LETTERS[Kernel.rand(26)] }
    numbers.times { new_name << Kernel.rand(10).to_s }
    if self.class.names.include? new_name
      generate_name(letters, numbers)
    else
      assign new_name
    end
  end

  def assign(name)
    self.class.names << name
    @name = name
  end
end
