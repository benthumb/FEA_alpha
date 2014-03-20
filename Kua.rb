require "./Logging.rb"
require "./utilities.rb"
require "./Profile.rb"

module Kua
  include Logging
  include Utilities

  # ************************ Instance Variables ************************ 
  @kua_number
  @group
  @auspicious_direction

  # ***************************** Constants **************************** 
  EAST_GROUP = %w(1 3 4 9)
  START_RANGE = 121
  END_RANGE = 221

  # ************ Setters getters / creational / constructive ***********
  attr_accessor :birthdate, :gender 

  def kua_number
    puts "Your number is :" << "5"
  end

  def kua_group
    puts "Your group is :" << "East"
  end

  def kua_auspicious_direction
    puts "Your auspicious direction is : " << "East"
  end

  def details
    kua_num = ""
    wasnt_in_range = true

    if is_in_range
      logger.debug "Birthday is in range: " << @birthdate
      birth_yr = det_calendar_yr(@birthdate)
      logger.debug "Calculated calendar year: " << @birthdate
      wasnt_in_range = false
    end

    if wasnt_in_range && birthdate[1] != "1"
      logger.debug "Wasn't in range and NOT in January!"
      last_two_digits = birthdate[6..7]
    elsif wasnt_in_range && birthdate[1] == "1"
      logger.debug "Wasn't in range and IN January!"
      last_two_digits_tmp = birthdate[6..7]
      prev_yr = last_two_digits_tmp.to_i - 1
      last_two_digits = prev_yr.to_s
    else
      logger.debug "WAS in Range ... well, you decide!"
      last_two_digits = birth_yr.to_s[2..3]
    end

    if gender == "male"
      sub_val = last_two_digits[0].to_i + last_two_digits[1].to_i
      kua_num = (10 - self.to_single_digit(sub_val)).to_s
    else
      sub_val = last_two_digits[0].to_i + last_two_digits[1].to_i
      test_val = 5 + self.to_single_digit(sub_val)
      if test_val >= 10
        kua_num = self.to_single_digit(test_val).to_s
      else
        kua_num = test_val.to_s
      end
    end

    @kua_number = kua_num
    if Kua::EAST_GROUP.include? @kua_number.to_s
      @group = "East"
    else
      @group = "West"
    end
    logger.debug "Profile details: " << @group << ", " << @kua_number
  end

  def is_in_range
    birth_d = @birthdate
    test_val = birth_d[0,4]

    if test_val[0] != "1" && 
      (test_val[1..4].to_i >= Kua::START_RANGE && 
       test_val[1..4].to_i <= Kua::END_RANGE)
      in_range = true
    else
      in_range = false
    end
  end

  def det_calendar_yr(birth_date)
    calendar_yr_calc_beta(get_year_lookup_hash(birth_date))
  end
end
