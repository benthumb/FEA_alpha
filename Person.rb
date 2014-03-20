require './Kua.rb'

class Person
  include Kua
  attr_reader :profile
  def initialize(profile)
    @profile = profile
    self.kua_init(@profile.birthdate, @profile.gender)
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
