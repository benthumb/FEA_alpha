require "./Logging.rb"
require "./utilities.rb"
require "./Profile.rb"

module Kua
  include Logging
  include Utilities

  # ************************ Instance Variables ************************ 
  @kua_number
  @kua_group
  @kua_auspicious_direction
  @birth_year
  @last_two_digits
  # ***************************** Constants **************************** 
  EAST_GROUP = %w(1 3 4 9)
  START_RANGE = 121
  END_RANGE = 221
  # ****************************** Symbols *****************************
  east_group = :east   
  west_group = :west
  # *********** Setters | Getters / Creational / Constructive **********
  attr_accessor :birthdate, :gender 
  attr_reader :kua_number, :kua_group, :kua_auspicious_direction

  def kua_init(birthdate, gender) 
    @not_in_range = true
    @birthdate = birthdate
    @gender = gender
    set_birth_year if is_in_range 
    set_last_two_digits_birth_year
    set_kua_number
    set_group
    set_auspicious_direction
  end
    
  def set_birth_year
    logger.debug "Birthday is in range: " << @birthdate
    @birth_year = det_calendar_yr(@birthdate)
    logger.debug "Calculated calendar year: " << @birthdate
    @not_in_range = false
  end

  def set_last_two_digits_birth_year 
	  logger.debug "Sanity check: " << 
	  "not in range - " << 
	  @not_in_range.to_s << 
	  " first digit of birthdate: " << 
	  @birthdate[1].to_s
    if @not_in_range && @birthdate[1] != "1"
      logger.debug "Wasn't in range and NOT in January!"
      @last_two_digits = @birthdate[6..7]
    elsif @not_in_range && @birthdate[1] == "1"
      logger.debug "Wasn't in range and IN January!"
      last_two_digits_tmp = @birthdate[6..7]
      prev_yr = last_two_digits_tmp.to_i - 1
      @last_two_digits = prev_yr.to_s
    else
      logger.debug "WAS in Range ... well, you decide!"
      @last_two_digits = @birth_year.to_s[2..3]
    end
  end

  def set_kua_number
    if @gender == "male"
      sub_val = @last_two_digits[0].to_i + @last_two_digits[1].to_i
      kua_num = (10 - self.to_single_digit(sub_val)).to_s
    else
      sub_val = @last_two_digits[0].to_i + @last_two_digits[1].to_i
      test_val = 5 + self.to_single_digit(sub_val)
      if test_val >= 10
        kua_num = self.to_single_digit(test_val).to_s
      else
        kua_num = test_val.to_s
      end
    end
    @kua_number = kua_num
  end

  def set_group
    if Kua::EAST_GROUP.include? @kua_number.to_s
      @kua_group = "East"
      #@group = :east 
    else
      @kua_group = "West"
    end
    logger.debug "Profile details: " << @kua_group << ", " << @kua_number
  end
  
  def set_auspicious_direction
    @kua_auspicious_direction = "East"  
  end

  def is_in_range
    logger.debug "First four digits of birthdate: " << @birthdate[0,4].to_s
    test_val = @birthdate[0,4]
    logger.debug "Test value: " << test_val[1..4].to_s
    if test_val[0] != "1" && 
      (test_val[1..4].to_i >= Kua::START_RANGE && 
       test_val[1..4].to_i <= Kua::END_RANGE)
      logger.debug "In range ... " << @birthdate.to_s
      in_range = true 
    else
      logger.debug "Not in range ... " << @birthdate.to_s
      in_range = false 
    end
  end

  def det_calendar_yr(birth_date)
    calendar_yr_calc_beta(get_year_lookup_hash(birth_date))
  end
end
