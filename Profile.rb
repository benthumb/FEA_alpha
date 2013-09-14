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

class Kua < Profile
  attr_accessor :group, :kua_number

  EAST_GROUP = ["1","3","4","9"]
  START_RANGE = 121
  END_RANGE = 221

  def details
    birthdate = @person.birthdate
    gender = @person.gender
    kua_num = ""
    wasnt_in_range = true

    if is_in_range
      logger.debug "Birthday is in range: " << birthdate
      birth_yr = det_calendar_yr(birthdate)
      logger.debug "Calculated calendar year: " << birthdate
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

    self.kua_number = kua_num
    if Kua::EAST_GROUP.include? self.kua_number.to_s
      self.group = "East"
    else
      self.group = "West"
    end
    logger.debug "Profile details: " << self.group << ", " << self.kua_number
  end

  def is_in_range
    birth_d = @person.birthdate
    test_val = birth_d[0,4]

    if test_val[0] != "1" && (test_val[1..4].to_i >= Kua::START_RANGE && test_val[1..4].to_i <= Kua::END_RANGE)
      in_range = true
    else
      in_range = false
    end
  end

  def det_calendar_yr(birth_date)
    calendar_yr_calc_beta(get_year_lookup_hash(birth_date))
  end

  def calendar_yr_calc_beta(dates_hash)
    random_val = 1
    last_day_jan = 31
    thirty_days = 30
    b_date = @person.birthdate

    yr_idx_end = b_date.length-1
    yr_idx_strt = yr_idx_end-3
    b_year = b_date[yr_idx_strt..yr_idx_end]

    date_new_moon = dates_hash[b_year]

    algorithm_1 = lambda do |date_tbd|
      var_nmd = date_tbd[4..5].to_i
      var_temp = var_nmd + thirty_days
      logger.debug "algo 1 ... var_temp value: " << var_temp.to_s
      if var_temp == 31
        return ("1" << var_temp.to_s).to_i
      else
        new_yr_date = var_temp - last_day_jan
        return ("2" << new_yr_date.to_s).to_i
      end
    end

    convert = lambda do |date_to_convert|
      logger.debug "converting date: " << date_to_convert.to_s
      test_s = date_to_convert.chomp
      months = Hash.new
      months["Jan"] = "1"
      months["Feb"] = "2"
      converted_s = months[test_s[0..2]] << test_s[4..5]
      return converted_s
    end

    formatted_date = lambda do |date_s|
      if date_s[2] == "0"
        #logger.debug "algo formatted date: " << date_s[1] << date_s[3]
        return date_s[1] << date_s[3]
      else
        #logger.debug "algo formatted date: " << date_s[1..3]
        return date_s[1..3]
      end
    end

    new_moon_date_format = convert[date_new_moon]

    # is date (new moon) before 121
    if new_moon_date_format.to_i < 121
      random_val = algorithm_1[date_new_moon]
    end

    # is date (new moon) between 121 and 221?
    if !(new_moon_date_format.to_i < 121) && !(new_moon_date_format.to_i > 221)
      random_val = convert[date_new_moon].to_i
    end

    b_date_f = formatted_date[b_date].to_i

    if b_date_f < random_val && !(random_val.to_s[0].to_i < b_date_f.to_s[0].to_i)
      return "" << (b_date[4..7].to_i - 1).to_s
    else
      return b_date[4..7]
    end
  end
end
