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

  # New algo implementation : will phase out <calendar_yr_calc_beta>
  def dates_to_compare(dates_hash, date_to_compare)
  # Basic algo: if birthdate < new moon date OR earliest possible new year's, 
  #   then birth year goes to prior year
  # Otherwise : if birthdate > new moon date, then
  # 1) estimate/calculate date of new year's celebration
  # 2) compare birthdate against above : < NYC date, goes to prior year; otherwise, goest to current year
	  
    year = date_to_compare.to_s[4..7]

    month = date_to_compare.to_s[0] != "0" ? date_to_compare.to_s[0..1] : date_to_compare.to_s[1] 

    day = date_to_compare.to_s[2] != "0" ? date_to_compare.to_s[2..3] : date_to_compare.to_s[3] 
   
    logger.debug "---------------- date_to_compare (year): " << year 
    logger.debug "---------------- date_to_compare (month): " << month 
    logger.debug "---------------- date_to_compare (day): " << day 

    b_date = date_to_compare 

    yr_idx_end = b_date.length-1
    yr_idx_strt = yr_idx_end-3
    
    b_year = date_to_compare[yr_idx_strt..yr_idx_end]

    date_new_moon = dates_hash[b_year]

    new_moon_date_arr = date_new_moon.split(" ");

    new_moon_month = new_moon_date_arr[0] == "Jan" ? "01":"02"

    new_moon_day = new_moon_date_arr[1]

    parsed_date_object_compare = Date.new(year.to_i, month.to_i, day.to_i)

    # ----------- Date of new moon
    parsed_date_object_new_moon =  Date.new(b_year.to_i,new_moon_month.to_i,new_moon_day.to_i)

    if(parsed_date_object_compare < new_years_day(parsed_date_object_new_moon))    
      prior_year = "" << (date_to_compare[4..7].to_i - 1).to_s
    else
      same_year = date_to_compare[4..7]
    end
  end

  def new_years_day(new_moon_date)
    # month, i.e., February or 2/21/YIQ (latest possible date) 
    latest_ny_month = 2         

    calculated_new_years_day = 0  # calculated new years day 
    yiq = new_moon_date.year      # year in question

    # month, i.e., 1/21/YIQ (earliest possible date) 
    earliest_ny_month = 1         

    # day, i.e., 1/21/YIQ (earliest possible date) 
    earliest_latest_ny_day = 21   

    # earliest possible new year's day/date 
    earliest_ny_date = Date.new(yiq, 
				earliest_ny_month, 
				earliest_latest_ny_day) 

    # latest possible new year's day/date 
    latest_ny_date = Date.new(yiq, 
				latest_ny_month, 
				earliest_latest_ny_day) 

    # advance date : new moon date < earliest possible new year's
    thirty_days = 30           

    # rollover point : earliest possible + 30 days
    last_day_jan = 31          

    # the DAY in date of New Year's  
    ny_day = (new_moon_date.day + thirty_days) % last_day_jan  

    # Is New Moon < (earlier) than Jan 21 YIQ : Date.new(YIQ,JAN,EARLIEST_DAY)

    # Does the date of the new moon fall before Jan, 21 YIQ 
    calculated_new_years_day = Date.new(yiq, latest_ny_month, ny_day) if
      new_moon_date < earliest_ny_date &&
      ny_day != 0  

    # Does the date of the new moon fall between Jan 21, YIQ and Feb 21, YIQ?
    calculated_new_years_day = new_moon_date if
      new_moon_date >= earliest_ny_date ||
      new_moon_date <= latest_ny_date 
  end
end

