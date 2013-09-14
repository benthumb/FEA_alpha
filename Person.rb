class Person
  # Setters getters / creational / constructive

  attr_reader :name, :birthdate, :birthplace, :gender
  def initialize(name, birthdate, birthplace, gender)
    @name = name
    @birthdate = birthdate
    @birthplace = birthplace
    @gender = gender
  end
end

class LoveInterest < Person

  attr_accessor :compatibility_score
  def is_compatible
    if compatibility_score >= 70
      thumbs_up = true
    else
      thumbs_up = false
    end
  end
end