require "./Logging.rb"
require "./utilities.rb"
# // This could be module too : it actually HAS to be one, 
# otherwise, no way to access instance variables...
class Profile

  # Constants
  NAME = 0
  BIRTH_DATE = 1
  BIRTH_PLACE = 2
  GENDER = 3

  # Setters getters / creational / constructive
  attr_accessor :name, :birthdate, :birthplace, :gender

  def initialize(*args)
    if args.length == 4
      @name = args[NAME]
      @birthdate = args[BIRTH_DATE]
      @birthplace = args[BIRTH_PLACE]
      @gender = args[GENDER]
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
