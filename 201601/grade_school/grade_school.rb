class School
  attr_accessor :school
  
  def initialize
    self.school = {}
  end
  
  def to_h
    return_hash = {}
    school.keys.sort.each do |level|
      return_hash[level] = school[level].sort
    end
    return_hash
  end
  
  def add(name, grade)
    school[grade] = [] unless school.key? grade
    school[grade] << name
  end
  
  def grade(level)
    return [] unless school.key? level
    school[level]
  end
end