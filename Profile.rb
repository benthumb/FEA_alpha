require "./Logging.rb"
require "./utilities.rb"

class Profile

  include Logging
  include Utilities

  # Setters getters / creational / constructive

  attr_reader :person
  def initialize(person)
    @person = person
    self.details
  end

  def details
    raise "Abstract Method!"
  end

  private :details
end
