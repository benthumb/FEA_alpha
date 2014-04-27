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
    @charlie_profile = Profile.new("Charlie Brown","09121966","New York","male")
    @charlie_brown = Person.new()
    @charlie_brown.set_profile @charlie_profile 

    logger.debug "Kua number " << @charlie_brown.kua_number
    logger.debug "Kua group " << @charlie_brown.kua_group
    logger.debug "Kua auspicious direction " << @charlie_brown.kua_auspicious_direction
    logger.debug "Charlie's profile (name): " << @charlie_brown.profile.name
    logger.debug "Charlie's profile (birthdate): " << @charlie_brown.profile.birthdate
    logger.debug "Charlie's profile (birthplace): " << @charlie_brown.profile.birthplace
    logger.debug "Charlie's profile (gender): " << @charlie_brown.profile.gender
    logger.debug "Charlie's birthday (is in range): " << @charlie_brown.is_in_range.to_s

    charlie_brown_prm_profile = Profile.new("Charlie Brown","09121966","New York","male")
    @charlie_brown_prm = Person.new()
    @charlie_brown_prm.set_profile  charlie_brown_prm_profile 

    psycho_profile = Profile.new("Psycho Killer","04011970","New Jersey","female")
    @psycho_killer = Person.new()
    @psycho_killer.set_profile psycho_profile 

    riki_profile = Profile.new("Riki Pretty","08271992","Tokyo","female")
    @riki_pretty = Person.new()
    @riki_pretty.set_profile riki_profile 

    slim_profile = Profile.new("Slim Pickings","05281942","Tokyo","male")
    @slim_pickings = Person.new()
    @slim_pickings.set_profile slim_profile 

    modest_profile = Profile.new("Modest Mouse","02141946","Saitama","female")
    @modest_mouse = Person.new()
    @modest_mouse.set_profile modest_profile 

    morris_profile = Profile.new("Morris Bill","01212004","New York","male")
    @morris_bill = Person.new()
    @morris_bill.set_profile morris_profile 

    charlie_profile = Profile.new("Charlie Nutz","01121967","Seattle","female")
    @charlie_nutz = Person.new()
    @charlie_nutz.set_profile charlie_profile 

    jim_profile = Profile.new("Jim Peace","02161984","Washington, DC","male")
    @jim_peace = Person.new()
    @jim_peace.set_profile jim_profile 

    tomoko_profile = Profile.new("Tomoko Saito","12101973","Hiroshima","female")
    @tomoko_saito = Person.new()
    @tomoko_saito.set_profile tomoko_profile 

    mitsuko_profile = Profile.new("Mitsuko","02111946","Matsuei","female")
    @mitsuko_matsuei = Person.new()
    @mitsuko_matsuei.set_profile mitsuko_profile

    jane_profile = Profile.new("Jane Krakowski","10111968","Chicago","female")
    @jane_krakowski = Person.new()
    @jane_krakowski.set_profile jane_profile 

    sarah_profile = Profile.new("Sarah Silverman","12011970","Manchester","female")
    @sarah_silverman = Person.new()
    @sarah_silverman.set_profile sarah_profile 

    colin_profile = Profile.new("Colin Powell","04051937","Queens","male")
    @colin_powell  = Person.new()
    @colin_powell.set_profile colin_profile 

    liyang = Profile.new("Liyang Xia","10241981","Shanghai","female")
    @liyang = Person.new()
    @liyang.set_profile liyang 

    # **************** Love Interests ****************
    @melissa_profile = Profile.new("Melissa Dooley","03121972","Los Angeles","female")
    @melissa_dooley_lv = LoveInterest.new()
    @melissa_dooley_lv.set_profile @melissa_profile 

    @indifferent_profile = Profile.new("Indifferent Dodger","07011970","Miami","female")
    @indifferent_dodger_lv = LoveInterest.new()
    @indifferent_dodger_lv.set_profile @indifferent_profile 

    @brain_profile = Profile.new("Brain Wartscht","12241997","Cancun","female")
    @brain_wartscht_lv = LoveInterest.new()
    @brain_wartscht_lv.set_profile @brain_profile 

    shirley_profile = Profile.new("Shirley Temple","01141901","Hollywood","female")
    @shirley_temple_lv = LoveInterest.new()
    @shirley_temple_lv.set_profile shirley_profile 

    mania_profile = Profile.new("Maniac","01271974","Pittsboig","male")
    @maniac_lv = LoveInterest.new()
    @maniac_lv.set_profile mania_profile

    sally_profile = Profile.new("Sally Mae","01222004","Los Angeles","female")
    @sally_mae_lv = LoveInterest.new()
    @sally_mae_lv.set_profile sally_profile 

    unhappy_profile = Profile.new("Unhappy Camper","03122004","Miami","female")
    @unhappy_camper_lv = LoveInterest.new()
    @unhappy_camper_lv.set_profile unhappy_profile 

    big_profile = Profile.new("Big Bertha","02082005","Cancun","female")
    @big_bertha_lv = LoveInterest.new()
    @big_bertha_lv.set_profile big_profile 
    
    # **************** Birth Dates ****************
    @july_test_birthdate1 = '07041974'
    @nov_test_birthdate2 = '11232001'
    @jan_test_birthdate3 = '01141902'
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
    puts "Name: " << @charlie_brown.profile.name
    puts "Birthdate: " << @charlie_brown.profile.birthdate
    puts "Birthplace: " << @charlie_brown.profile.birthplace
    puts "Gender: " << @charlie_brown.profile.gender

    # Use setters to create person instance w/ same info
    @instance_a = [@charlie_brown.profile.name,
                   @charlie_brown.profile.birthdate,
		   @charlie_brown.profile.birthplace,
		   @charlie_brown.profile.gender]
    @instance_b = [@charlie_brown_prm.profile.name,
		   @charlie_brown_prm.profile.birthdate,
		   @charlie_brown_prm.profile.birthplace,
		   @charlie_brown_prm.profile.gender]
    @instance_c = [@psycho_killer.profile.name,
		   @psycho_killer.profile.birthdate,
		   @psycho_killer.profile.birthplace,
		   @psycho_killer.profile.gender]

    self.assert_equal(@instance_a,@instance_b)
    self.assert_not_equal(@instance_a,@instance_c)
  end

  def create_love_interest_instance
    # Use initialization to construct love interest instance:
    puts "//+++++++++++++ TEST: Create Love Interest Instance +++++++++++++//"
    puts "Newly initialized love interest:"
    puts "Name: " << @melissa_dooley_lv.profile.name
    puts "Birthdate: " << @melissa_dooley_lv.profile.birthdate
    puts "Birthplace: " << @melissa_dooley_lv.profile.birthplace
    puts "Gender: " << @melissa_dooley_lv.profile.gender

    # Use setters to create person instance w/ same info
    melissa_dooley_lv_prm_profile = Profile.new()
    melissa_dooley_lv_prm_profile.name = "Melissa Dooley"
    melissa_dooley_lv_prm_profile.birthdate = "03121972"
    melissa_dooley_lv_prm_profile.birthplace = "Los Angeles"
    melissa_dooley_lv_prm_profile.gender = "female"
    melissa_dooley_lv_prm = LoveInterest.new()
    melissa_dooley_lv_prm.set_profile melissa_dooley_lv_prm_profile

    joan_baez_lv_profile = Profile.new()
    joan_baez_lv_profile.name = "Joan Baez"
    joan_baez_lv_profile.birthdate = "01011970"
    joan_baez_lv_profile.birthplace = "Boston"
    joan_baez_lv_profile.gender = "transgender"
    joan_baez_lv = LoveInterest.new()
    joan_baez_lv.set_profile joan_baez_lv_profile

    @instance_a = [@melissa_dooley_lv.profile.name,
		   @melissa_dooley_lv.profile.birthdate,
		   @melissa_dooley_lv.profile.birthplace,
		   @melissa_dooley_lv.profile.gender]

    @instance_b = [melissa_dooley_lv_prm.profile.name,
		   melissa_dooley_lv_prm.profile.birthdate,
		   melissa_dooley_lv_prm.profile.birthplace,
		   melissa_dooley_lv_prm.profile.gender]

    @instance_c = [joan_baez_lv.profile.name,
		   joan_baez_lv.profile.birthdate,
		   joan_baez_lv.profile.birthplace,
		   joan_baez_lv.profile.gender]

    self.assert_equal(@instance_a,@instance_b)
    self.assert_not_equal(@instance_a,@instance_c)

    @melissa_dooley_lv.compatibility_score = 90
    joan_baez_lv.compatibility_score = 40

    puts "//+++++++++++++ TEST: Compatibility Cut-off +++++++++++++//"
    self.assert_equal(@melissa_dooley_lv.is_compatible,true)
    self.assert_not_equal(joan_baez_lv.is_compatible,true)
  end

  def kua_profile
    kua_dimension_a = @charlie_brown
    kua_dimension_b = @melissa_dooley_lv
    kua_dimension_c = @indifferent_dodger_lv
    kua_dimension_d = @brain_wartscht_lv
    kua_dimension_e = @riki_pretty
    kua_dimension_f = @slim_pickings

    puts "//+++++++++++++ TEST: Kua Profile +++++++++++++//"
    puts "dimension A: " << kua_dimension_a.kua_group << " " << kua_dimension_a.kua_number
    puts "dimension B: " << kua_dimension_b.kua_group << " " << kua_dimension_b.kua_number
    puts "dimension C: " << kua_dimension_c.kua_group << " " << kua_dimension_c.kua_number
    puts "dimension D: " << kua_dimension_d.kua_group << " " << kua_dimension_d.kua_number
    puts "dimension E: " << kua_dimension_e.kua_group << " " << kua_dimension_e.kua_number
    puts "dimension F: " << kua_dimension_f.kua_group << " " << kua_dimension_f.kua_number

    # http://www.smilingbamboo.com/feng-shui-kua/my-kua-number-4.php

    self.assert_equal(kua_dimension_a.kua_group,kua_dimension_b.kua_group)
    self.assert_not_equal(kua_dimension_a.kua_group,kua_dimension_c.kua_group)
    self.assert_not_equal(kua_dimension_d.kua_group,kua_dimension_e.kua_group)
    self.assert_not_equal(kua_dimension_e.kua_group,kua_dimension_f.kua_group)
    self.assert_not_equal(kua_dimension_d.kua_number,kua_dimension_e.kua_number)
    self.assert_not_equal(kua_dimension_e.kua_number,kua_dimension_f.kua_number)
  end

  def birthdate_in_range
    person_a = @slim_pickings
    person_b = @modest_mouse
    person_c = @shirley_temple_lv
    person_d = @maniac_lv

    puts "//+++++++++++++ TEST: Birthdate is In Range +++++++++++++//"
    self.assert_equal(person_a.is_in_range,false)
    self.assert_equal(person_b.is_in_range,true)
    self.assert_equal(person_c.is_in_range,false)
    self.assert_equal(person_d.is_in_range,true)
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
    @charlie_brown.profile.birthdate = '01191957' 
    charlie_brown_b = @charlie_brown.profile.birthdate 
    dates_hash = get_year_lookup_hash(charlie_brown_b) 
    year_1 = dates_to_compare(dates_hash, charlie_brown_b)

    @melissa_dooley_lv.profile.birthdate = '01231958' 
    melissa_dooley_lv_b = @melissa_dooley_lv.profile.birthdate 
    dates_hash = get_year_lookup_hash(melissa_dooley_lv_b) 
    year_2 = dates_to_compare(dates_hash, melissa_dooley_lv_b)

    @indifferent_dodger_lv.profile.birthdate = '12221957' 
    indifferent_dodger_lv_b = @indifferent_dodger_lv.profile.birthdate 
    dates_hash = get_year_lookup_hash(indifferent_dodger_lv_b) 
    year_3 = dates_to_compare(dates_hash, indifferent_dodger_lv_b)

    @brain_wartscht_lv.profile.birthdate = '02011958' 
    brain_wartscht_lv_b = @brain_wartscht_lv.profile.birthdate 
    dates_hash = get_year_lookup_hash(brain_wartscht_lv_b) 
    year_4 = dates_to_compare(dates_hash, brain_wartscht_lv_b)

    logger.debug "year 1957: " << year_1
    logger.debug "year 1957: " << year_2
    logger.debug "year 1957: " << year_3
    logger.debug "year 1958: " << year_4

    assert_equal(year_1,"1956")
    assert_equal(year_2,"1957")
    assert_equal(year_3,"1957")
    assert_equal(year_4,"1958")

    # Phase in : new implementation of algo will be worked in from here
    @morris_bill.profile.birthdate = '01192004' 
    morris_bill_b = @morris_bill.profile.birthdate 
    dates_hash = get_year_lookup_hash(morris_bill_b)
    year_5_tst = dates_to_compare(dates_hash, morris_bill_b)

    @sally_mae_lv.profile.birthdate = '01112005' 
    sally_mae_lv_b = @sally_mae_lv.profile.birthdate 
    dates_hash = get_year_lookup_hash(sally_mae_lv_b)
    year_6_tst = dates_to_compare(dates_hash, sally_mae_lv_b)

    @unhappy_camper_lv.profile.birthdate = '01312004' 
    unhappy_camper_lv_b = @unhappy_camper_lv.profile.birthdate 
    dates_hash = get_year_lookup_hash(unhappy_camper_lv_b)
    year_7_tst = dates_to_compare(dates_hash, unhappy_camper_lv_b)

    @big_bertha_lv.profile.birthdate = '01182005' 
    big_bertha_lv_b = @big_bertha_lv.profile.birthdate 
    dates_hash = get_year_lookup_hash(big_bertha_lv_b)
    year_8_tst = dates_to_compare(dates_hash, big_bertha_lv_b)

    logger.debug "year 2004: " << year_5_tst
    logger.debug "year 2004: " << year_6_tst
    logger.debug "year 2004: " << year_7_tst
    logger.debug "year 2005: " << year_8_tst

    assert_equal(year_5_tst,"2003")
    assert_equal(year_6_tst,"2004")
    assert_equal(year_7_tst,"2004")
    assert_equal(year_8_tst,"2004")
  end

  def kua_dimension_details
  # for comparison - http://redlotusletter.com/resources/kua-calculator/
    puts "//+++++++++++++ TEST: Kua Profile - details +++++++++++++//"
    puts "Nutz's kua number is: " << @charlie_nutz.kua_number
    puts "Nutz's group is: " << @charlie_nutz.kua_group

    assert_equal(@charlie_nutz.kua_number, "8")
    assert_equal(@charlie_nutz.kua_group, "West")

    puts "Peace's kua number is: " << @jim_peace.kua_number
    puts "Peace's group is: " << @jim_peace.kua_group

    assert_equal(@jim_peace.kua_number, "7")
    assert_equal(@jim_peace.kua_group, "West")

    puts "Tomoko's kua number is: " << @tomoko_saito.kua_number
    puts "Tomoko's group is: " << @tomoko_saito.kua_group

    assert_equal(@tomoko_saito.kua_number, "6")
    assert_equal(@tomoko_saito.kua_group, "West")

    puts "Mitsuko's kua number is: " << @mitsuko_matsuei.kua_number
    puts "Mitsuko's kua_group is: " << @mitsuko_matsuei.kua_group

    assert_equal(@mitsuko_matsuei.kua_number, "6")
    assert_equal(@mitsuko_matsuei.kua_group, "West")

    puts "Jane's kua number is: " << @jane_krakowski.kua_number
    puts "Jane's kua_group is: " << @jane_krakowski.kua_group

    assert_equal(@jane_krakowski.kua_number, "1")
    assert_equal(@jane_krakowski.kua_group, "East")

    puts "Sarah's kua number is: " << @sarah_silverman.kua_number
    puts "Sarah's kua_group is: " << @sarah_silverman.kua_group

    assert_equal(@sarah_silverman.kua_number, "3")
    assert_equal(@sarah_silverman.kua_group, "East")

    puts "Colin's kua number is: " << @colin_powell.kua_number
    puts "Colin's kua_group is: " << @colin_powell.kua_group

    assert_equal(@colin_powell.kua_number, "9")
    assert_equal(@colin_powell.kua_group, "East")

    puts "Liyang's kua number is: " << @liyang.kua_number
    puts "Liyang's kua_group is: " << @liyang.kua_group

    assert_equal(@liyang.kua_number, "5")
    assert_equal(@liyang.kua_group, "West")
  end

  def run
    self.setup_test_data
    self.create_person_instance
    self.create_love_interest_instance
    self.kua_profile
    self.birthdate_in_range
    self.year_lookup_hash
    self.calendar_year
    self.kua_dimension_details
    puts "*************** Test Stats ***************"
    puts "Total Tests: " << (self.passed_tests + self.failed_tests).to_s
    puts "Passed Tests: " << self.passed_tests.to_s
    puts "Failed Tests: " << self.failed_tests.to_s
  end
end

tests = Tests.new()
tests.run
