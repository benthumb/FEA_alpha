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

    #------------------- second part of algo ------------------------ 
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
    #------------------- second part of algo ------------------------ 
  end
