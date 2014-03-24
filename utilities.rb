require "./Logging.rb"
require 'date'

module Utilities

  include Logging
  def get_year_lookup_hash(b_day)
    year = nil
    date_new_moon = nil
    dates = Hash.new
    century = (b_day.length)-4
    cnt = 0

    if b_day[century] == "1"
      f1 = File.open('./data/output.txt','r')
    else
      logger.debug "else clause of b_day test..."
      f1 = File.open('./data/output2001.txt','r')
    end

    while line = f1.gets
      if !(year == nil || date_new_moon ==  nil)
      #if (year != nil && date_new_moon !=  nil) equivalent ... no doubt
        #logger.debug "Passed nil test ... populating hash: " << line
        dates[year] = date_new_moon.chomp
        year, date_new_moon = nil
      end

      if  line =~ /^\d/
        #logger.debug "set year: " << line
        year = line.chomp
      end

      if  line =~ /^\D/
        #logger.debug "setting date: " << line
        date_new_moon = line.chomp
      end
    end
    dates[year] = date_new_moon.chomp
    #puts dates
    #puts dates.length
    #          logger.debug "What kind of object am I (get hash method): " << dates.inspect
    return dates
  end

  def to_single_digit(number)
    if number < 10
      single_digit = number
    else
      two_digits = number.to_s
      number = two_digits[0].to_i + two_digits[1].to_i
      self.to_single_digit(number)
    end
  end

  def calendar_yr_calc_beta(dates_hash, birth_date)
    random_val = 1
    last_day_jan = 31
    thirty_days = 30
    b_date = birth_date 

    yr_idx_end = b_date.length-1
    yr_idx_strt = yr_idx_end-3
    b_year = b_date[yr_idx_strt..yr_idx_end]

    date_new_moon = dates_hash[b_year]

    # --------------------------new year's celebration date algo
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
    # --------------------------new year's celebration date algo
    
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
    logger.debug "New moon: formatted date - " << new_moon_date_format.to_s 

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

  def date_compare(date_to_compare)
    parsed_date_object = parse_date(date_to_compare)
    logger.debug "Date to compare is earlier!" if parsed_date_object < Date.new(2010,1,22) 
    logger.debug "Date to compare is later!" if parsed_date_object > Date.new(2010,1,22) 
  end

  # New algo implementation : will phase out <calendar_yr_calc_beta>
  def dates_to_compare(dates_hash, date_to_compare)
  # Basic algo: if birthdate < new moon date OR earliest possible new year's, 
  #   then birth year goes to prior year
  # Otherwise : if birthdate > new moon date, then
  # 1) estimate/calculate date of new year's celebration
  # 2) compare birthdate against above : < NYC date, goes to prior year; otherwise, goest to current year
    random_val = 1
    last_day_jan = 31
    thirty_days = 30
#    b_date = birth_date 
    b_date = date_to_compare 

    yr_idx_end = b_date.length-1
    yr_idx_strt = yr_idx_end-3
    
    b_year = date_to_compare[yr_idx_strt..yr_idx_end]
    earliest_ny_celebration = "0121" + b_year 
    parsed_date_earliest = parse_date(earliest_ny_celebration) 

    logger.debug "*********** b_year: " << b_year 
    date_new_moon = dates_hash[b_year]
    logger.debug "*********** Date of new moon: " << date_new_moon 

    new_moon_date_arr = date_new_moon.split(" ");
    new_moon_month = new_moon_date_arr[0] == "Jan" ? "01":"02"
    new_moon_day = new_moon_date_arr[1]
    new_moon_date = new_moon_month + new_moon_day + b_year 
    logger.debug "*********** formatted new moon date: " << new_moon_date

    parsed_date_object_compare = parse_date(date_to_compare)
    parsed_date_object_new_moon = parse_date(new_moon_date)
    logger.debug "Date to compare is earlier!" if parsed_date_object_compare < parsed_date_object_new_moon
    logger.debug "Date to compare is later!" if parsed_date_object_compare > parsed_date_object_new_moon
  
    # tbd : elsif clause - compare against calculated new year's celeb date ...   
    if(parsed_date_object_compare < parsed_date_earliest || 
       parsed_date_object_compare < parsed_date_object_new_moon ||
       parsed_date_object_compare < new_years_day(new_moon_date, parsed_date_earliest.year))
      prior_year = "" << (b_date[4..7].to_i - 1).to_s
    else
      same_year = b_date[4..7]
    end
  end

  def new_years_day(new_moon_date, year)
    thirty_days = 30
    last_day_jan = 31
    logger.debug ">>>>>>>>> New moon date: " << new_moon_date
    var_nmd = new_moon_date[4..5].to_i
    var_temp = var_nmd + thirty_days
    logger.debug "algo 1 ... var_temp value: " << var_temp.to_s
    if var_temp == 31
      logger.debug "returning var_temp value: " << "1" << var_temp.to_s
      nyc_date = parse_date("1" + var_temp + year)
#      return ("1" << var_temp.to_s).to_i
    else
      new_yr_date = var_temp - last_day_jan
      logger.debug "returning new_yr_date: " << "2" << new_yr_date.to_s
      nyc_date = parse_date("2" << new_yr_date.to_s << year.to_s)
#      return ("2" << new_yr_date.to_s).to_i
    end
  end

  def parse_date(date_string)
    month, day, year = ""
    if(date_string.length == 6)
      logger.debug "Date to parse 6 chars: " << date_string
      month = date_string[0].to_i 
      logger.debug "Month: " << month.to_s
      day = date_string[1].to_i 
      logger.debug "Day: " << day.to_s
      year = date_string[2..5].to_i 
      logger.debug "Year: " << year.to_s 
    elsif(date_string.length == 7)
      logger.debug "Date to parse 7 chars: " << date_string
      month = date_string[0].to_i 
      logger.debug "Month: " << month.to_s
      day = date_string[1..2].to_i 
      logger.debug "Day: " << day.to_s
      year = date_string[3..6].to_i 
      logger.debug "Year: " << year.to_s 
    else
      logger.debug "Date to parse 8 chars: " << date_string
      month = date_string[0..1].to_i 
      logger.debug "Month: " << month.to_s
      day = date_string[2..3].to_i 
      logger.debug "Day: " << day.to_s
      year = date_string[4..7].to_i 
      logger.debug "Year: " << year.to_s 
    end
    Date.new(year,month,day)
  end
end

