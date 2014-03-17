class Person
  # Setters getters / creational / constructive

  attr_accessor :name, :birthdate, :birthplace, :gender

  def initialize(*args)
    if args.length == 4
      @name = args[0]
      @birthdate = args[1]
      @birthplace = args[2]
      @gender = args[3]
    elsif args.length == 0 
      @name = '' 
      @birthdate = ''
      @birthplace = ''
      @gender = ''
    else
      raise ArgumentError, 'Number of arguments required are 4 or 0'
    end
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
