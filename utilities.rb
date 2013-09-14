require "./Logging.rb"

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
end

