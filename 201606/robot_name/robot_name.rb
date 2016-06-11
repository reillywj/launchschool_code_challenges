class Robot
  LETTERS = ('A'..'Z').to_a.freeze
  
  class << self; attr_accessor :names end
  @names = []

  attr_reader :name

  def initialize
    generate_name
  end

  def reset
    self.class.names.delete name
    generate_name
  end

  private

  def generate_name
    new_name = ''
    2.times { new_name << LETTERS[Kernel.rand(26)] }
    3.times { new_name << Kernel.rand(10).to_s }
    if self.class.names.include? new_name
      generate_name
    else
      assign new_name
    end
  end

  def assign(name)
    self.class.names << name
    @name = name
  end
end
