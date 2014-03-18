require './Profile.rb'
require './Person.rb'
require './utilities.rb'
require './Logging.rb'

class Tests

  include Logging
  include Utilities

  attr_accessor :failed_tests, :passed_tests

  def setup_test_data
    # **************** People ****************
    @charlie_brown = Person.new("Charlie Brown","09121966","New York","male")
    @charlie_brown_prm = Person.new("Charlie Brown","09121966","New York","male")
    @psycho_killer = Person.new("Psycho Killer","04011970","New Jersey","female")
    @riki_pretty = Person.new("Riki Pretty","08271992","Tokyo","female")
    @slim_pickings = Person.new("Slim Pickings","05281942","Tokyo","male")
    @modest_mouse = Person.new("Modest Mouse","02141946","Saitama","female")
    @morris_bill = Person.new("Morris Bill","01212004","New York","male")
    @charlie_nutz = Person.new("Charlie Nutz","01121967","Seattle","female")
    @jim_peace = Person.new("Jim Peace","02161984","Washington, DC","male")
    @tomoko_saito = Person.new("Tomoko Saito","12101973","Hiroshima","female")
    @mitsuko_matsuei = Person.new("Mitsuko","02111946","Matsuei","female")
    @jane_krakowski = Person.new("Jane Krakowski","10111968","Chicago","female")
    @sarah_silverman = Person.new("Sarah Silverman","12011970","Manchester","female")

    # **************** Love Interests ****************
    @melissa_dooley_lv = LoveInterest.new("Melissa Dooley","03121972","Los Angeles","female")
    @indifferent_dodger_lv = LoveInterest.new("Indifferent Dodger","07011970","Miami","female")
    @brain_wartscht_lv= LoveInterest.new("Brain Wartscht","12241997","Cancun","female")
    @shirley_temple_lv = LoveInterest.new("Shirley Temple","01141901","Hollywood","female")
    @maniac_lv = LoveInterest.new("Maniac","01271974","Pittsboig","male")
    @sally_mae_lv = LoveInterest.new("Sally Mae","01222004","Los Angeles","female")
    @unhappy_camper_lv = LoveInterest.new("Unhappy Camper","03122004","Miami","female")
    @big_bertha_lv = LoveInterest.new("Big Bertha","02082005","Cancun","female")
    
    # **************** Birth Dates ****************
    @july_test_birthdate1 = '07041974'
    @nov_test_birthdate2 = '11232001'
    @jan_test_birthdate3 = '01141902'

    # **************** Kua Profile ****************
    @kua_profile_nutz = Kua.new(@charlie_nutz)
    @kua_profile_peace = Kua.new(@jim_peace)
    @kua_profile_tomoko = Kua.new(@tomoko_saito)
    @kua_profile_mitsuko = Kua.new(@mitsuko_matsuei)
    @kua_profile_kraw = Kua.new(@jane_krakowski)
    @kua_profile_sarah = Kua.new(@sarah_silverman)

    # // ****** GROUP 1: Rooster ******     # Rooster - 1957-01-31 -> 1958-02-18
    @kua_profile_charlie = Kua.new(@charlie_brown)
    @kua_profile_melissa = Kua.new(@melissa_dooley_lv)
    @kua_profile_indiff = Kua.new(@indifferent_dodger_lv)
    @kua_profile_wart = Kua.new(@brain_wartscht_lv)

    # // ****** GROUP 2: Monkey ******     # Monkey - 2004-01-22 -> 2005-02-09
    @kua_profile_bill = Kua.new(@morris_bill)
    @kua_profile_sally = Kua.new(@sally_mae_lv)
    @kua_profile_unhappy = Kua.new(@unhappy_camper_lv)
    @kua_profile_bertha = Kua.new(@big_bertha_lv)
  end 

  def initialize
    @failed_tests = 0
    @passed_tests = 0
  end

  def assert_equal(obj_a,obj_b)
    if obj_a == obj_b
      puts "PASSED!"
      self.passed_tests += 1
    else
      puts "FAILED!"
      self.failed_tests += 1
    end
  end

  def assert_not_equal(obj_a,obj_b)
    if obj_a != obj_b
      puts "PASSED!"
      self.passed_tests += 1
    else
      puts "FAILED!"
      self.failed_tests += 1
    end
  end

  def create_person_instance
    # Use initialization to construct person instance:
    puts "//+++++++++++++ TEST: Create Person Instance +++++++++++++//"
    puts "Newly initialized person:"
    puts "Name: " << @charlie_brown.name
    puts "Birthdate: " << @charlie_brown.birthdate
    puts "Birthplace: " << @charlie_brown.birthplace
    puts "Gender: " << @charlie_brown.gender

    # Use setters to create person instance w/ same info

    @instance_a = [@charlie_brown.name,
		   @charlie_brown.birthdate,
		   @charlie_brown.birthplace,
		   @charlie_brown.gender]
    @instance_b = [@charlie_brown_prm.name,
		   @charlie_brown_prm.birthdate,
		   @charlie_brown_prm.birthplace,
		   @charlie_brown_prm.gender]
    @instance_c = [@psycho_killer.name,
		   @psycho_killer.birthdate,
		   @psycho_killer.birthplace,
		   @psycho_killer.gender]

    self.assert_equal(@instance_a,@instance_b)
    self.assert_not_equal(@instance_a,@instance_c)
  end

  def create_love_interest_instance
    # Use initialization to construct love interest instance:
    puts "//+++++++++++++ TEST: Create Love Interest Instance +++++++++++++//"
    puts "Newly initialized love interest:"
    puts "Name: " << @melissa_dooley_lv.name
    puts "Birthdate: " << @melissa_dooley_lv.birthdate
    puts "Birthplace: " << @melissa_dooley_lv.birthplace
    puts "Gender: " << @melissa_dooley_lv.gender

    # Use setters to create person instance w/ same info
    melissa_dooley_lv_prm = LoveInterest.new()
    melissa_dooley_lv_prm.name = "Melissa Dooley"
    melissa_dooley_lv_prm.birthdate = "03121972"
    melissa_dooley_lv_prm.birthplace = "Los Angeles"
    melissa_dooley_lv_prm.gender = "female"

    joan_baez_lv = LoveInterest.new()
    joan_baez_lv.name = "Joan Baez"
    joan_baez_lv.birthdate = "01011970"
    joan_baez_lv.birthplace = "Boston"
    joan_baez_lv.gender = "transgender"

    @instance_a = [@melissa_dooley_lv.name,
		   @melissa_dooley_lv.birthdate,
		   @melissa_dooley_lv.birthplace,
		   @melissa_dooley_lv.gender]

    @instance_b = [melissa_dooley_lv_prm.name,
		   melissa_dooley_lv_prm.birthdate,
		   melissa_dooley_lv_prm.birthplace,
		   melissa_dooley_lv_prm.gender]

    @instance_c = [joan_baez_lv.name,
		   joan_baez_lv.birthdate,
		   joan_baez_lv.birthplace,
		   joan_baez_lv.gender]

    self.assert_equal(@instance_a,@instance_b)
    self.assert_not_equal(@instance_a,@instance_c)

    @melissa_dooley_lv.compatibility_score = 90
    joan_baez_lv.compatibility_score = 40

    puts "//+++++++++++++ TEST: Compatibility Cut-off +++++++++++++//"
    self.assert_equal(@melissa_dooley_lv.is_compatible,true)
    self.assert_not_equal(joan_baez_lv.is_compatible,true)
  end

  def kua_profile

    kua_profile_a = Kua.new(@charlie_brown)
    kua_profile_b = Kua.new(@melissa_dooley_lv)
    kua_profile_c = Kua.new(@indifferent_dodger_lv)
    kua_profile_d = Kua.new(@brain_wartscht_lv)
    kua_profile_e = Kua.new(@riki_pretty)
    kua_profile_f = Kua.new(@slim_pickings)

    puts "//+++++++++++++ TEST: Kua Profile +++++++++++++//"
    puts "Profile A: " << kua_profile_a.group << " " << kua_profile_a.kua_number
    puts "Profile B: " << kua_profile_b.group << " " << kua_profile_b.kua_number
    puts "Profile C: " << kua_profile_c.group << " " << kua_profile_c.kua_number
    puts "Profile D: " << kua_profile_d.group << " " << kua_profile_d.kua_number
    puts "Profile E: " << kua_profile_e.group << " " << kua_profile_e.kua_number
    puts "Profile F: " << kua_profile_f.group << " " << kua_profile_f.kua_number

    # http://www.smilingbamboo.com/feng-shui-kua/my-kua-number-4.php

    self.assert_equal(kua_profile_a.group,kua_profile_b.group)
    self.assert_not_equal(kua_profile_a.group,kua_profile_c.group)
    self.assert_not_equal(kua_profile_d.group,kua_profile_e.group)
    self.assert_not_equal(kua_profile_e.group,kua_profile_f.group)
    self.assert_not_equal(kua_profile_d.kua_number,kua_profile_e.kua_number)
    self.assert_not_equal(kua_profile_e.kua_number,kua_profile_f.kua_number)

  end

  def birthdate_in_range
    kua_profile_a = Kua.new(@slim_pickings)
    kua_profile_b = Kua.new(@modest_mouse)
    kua_profile_c = Kua.new(@shirley_temple_lv)
    kua_profile_d = Kua.new(@maniac_lv)

    puts "//+++++++++++++ TEST: Birthdate is In Range +++++++++++++//"
    self.assert_equal(kua_profile_a.is_in_range,false)
    self.assert_equal(kua_profile_b.is_in_range,true)
    self.assert_equal(kua_profile_c.is_in_range,false)
    self.assert_equal(kua_profile_d.is_in_range,true)
  end

  def year_lookup_hash

    ans_1974 = "Jan 23 11:02"
    ans_2001 = "Jan 24 13:07"
    ans_1902 = "Jan 9 21:14"

    yr_hash1 = get_year_lookup_hash(@july_test_birthdate1)
    yr_hash2 = get_year_lookup_hash(@nov_test_birthdate2)
    yr_hash3 = get_year_lookup_hash(@jan_test_birthdate3)

    puts "//+++++++++++++ TEST: Get Year Lookup Hash +++++++++++++//"

    logger.debug "hash 1974: " << yr_hash1['1974'].to_s
    assert_equal(yr_hash1['1974'].to_s,ans_1974)

    logger.debug "hash 2001: " << yr_hash2['2001'].to_s
    assert_equal(yr_hash2['2001'].to_s,ans_2001)

    logger.debug "hash 1902: " << yr_hash1['1902'].to_s
    assert_equal(yr_hash3['1902'].to_s,ans_1902)

    logger.debug "utils instance methods: " << Utilities.instance_methods.to_s
  end

  def calendar_year
    # TBD - new year begins and ends on same day,
    # so will have to refine this model to include
    # hour and minutes as a rubric...

    # TBD - algorithm to calculate date of new year
    # fails in some cases: a day early ... will
    # have to look into rules more closely/carefully

    # Rooster - 1957-01-31 -> 1958-02-18
    # Monkey - 2004-01-22 -> 2005-02-09

    puts "//+++++++++++++ TEST: Det Calendar Yr Beta +++++++++++++//"
    year_1 = @kua_profile_charlie.calendar_yr_calc_beta(get_year_lookup_hash(@charlie_brown.birthdate))
    year_2 = @kua_profile_melissa.calendar_yr_calc_beta(get_year_lookup_hash(@melissa_dooley_lv.birthdate))
    year_3 = @kua_profile_indiff.calendar_yr_calc_beta(get_year_lookup_hash(@indifferent_dodger_lv.birthdate))
    year_4 = @kua_profile_wart.calendar_yr_calc_beta(get_year_lookup_hash(@brain_wartscht_lv.birthdate))

    logger.debug "year 1957: " << year_1
    logger.debug "year 1957: " << year_2
    logger.debug "year 1957: " << year_3
    logger.debug "year 1958: " << year_4

    assert_equal(year_1,"1956")
    assert_equal(year_2,"1957")
    assert_equal(year_3,"1957")
    assert_equal(year_4,"1958")

    year_5 = @kua_profile_bill.calendar_yr_calc_beta(get_year_lookup_hash(@morris_bill.birthdate))
    year_6 = @kua_profile_sally.calendar_yr_calc_beta(get_year_lookup_hash(@sally_mae_lv.birthdate))
    year_7 = @kua_profile_unhappy.calendar_yr_calc_beta(get_year_lookup_hash(@unhappy_camper_lv.birthdate))
    year_8 = @kua_profile_bertha.calendar_yr_calc_beta(get_year_lookup_hash(@big_bertha_lv.birthdate))

    logger.debug "year 2004: " << year_5
    logger.debug "year 2004: " << year_6
    logger.debug "year 2004: " << year_7
    logger.debug "year 2005: " << year_8

    assert_equal(year_5,"2003")
    assert_equal(year_6,"2004")
    assert_equal(year_7,"2004")
    assert_equal(year_8,"2004")
  end

  def kua_profile_details
    puts "//+++++++++++++ TEST: Kua Profile - details +++++++++++++//"
    puts "Profile details: " << @kua_profile_nutz.details.to_s
    puts "Nutz's kua number is: " << @kua_profile_nutz.kua_number
    puts "Nutz's group is: " << @kua_profile_nutz.group

    assert_equal(@kua_profile_nutz.kua_number, "8")
    assert_equal(@kua_profile_nutz.group, "West")

    puts "Profile details: " << @kua_profile_peace.details.to_s
    puts "Peace's kua number is: " << @kua_profile_peace.kua_number
    puts "Peace's group is: " << @kua_profile_peace.group

    assert_equal(@kua_profile_peace.kua_number, "7")
    assert_equal(@kua_profile_peace.group, "West")

    puts "Profile details: " << @kua_profile_tomoko.details.to_s
    puts "Tomoko's kua number is: " << @kua_profile_tomoko.kua_number
    puts "Tomoko's group is: " << @kua_profile_tomoko.group

    assert_equal(@kua_profile_tomoko.kua_number, "6")
    assert_equal(@kua_profile_tomoko.group, "West")

    puts "Profile details: " << @kua_profile_mitsuko.details.to_s
    puts "Mitsuko's kua number is: " << @kua_profile_mitsuko.kua_number
    puts "Mitsuko's group is: " << @kua_profile_mitsuko.group

    assert_equal(@kua_profile_mitsuko.kua_number, "6")
    assert_equal(@kua_profile_mitsuko.group, "West")

    puts "Profile details: " << @kua_profile_kraw.details.to_s
    puts "Jane's kua number is: " << @kua_profile_kraw.kua_number
    puts "Jane's group is: " << @kua_profile_kraw.group

    assert_equal(@kua_profile_kraw.kua_number, "1")
    assert_equal(@kua_profile_kraw.group, "East")

    puts "Profile details: " << @kua_profile_sarah.details.to_s
    puts "Sarah's kua number is: " << @kua_profile_sarah.kua_number
    puts "Sarah's group is: " << @kua_profile_sarah.group

    assert_equal(@kua_profile_sarah.kua_number, "1")
    assert_equal(@kua_profile_sarah.group, "East")
  end

  def run
    self.setup_test_data
    self.create_person_instance
    self.create_love_interest_instance
    self.kua_profile
    self.birthdate_in_range
    self.year_lookup_hash
    self.calendar_year
    self.kua_profile_details
    puts "*************** Test Stats ***************"
    puts "Total Tests: " << (self.passed_tests + self.failed_tests).to_s
    puts "Passed Tests: " << self.passed_tests.to_s
    puts "Failed Tests: " << self.failed_tests.to_s
  end
end

tests = Tests.new()
tests.run
