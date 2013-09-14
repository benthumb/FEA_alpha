require './Profile.rb'
require './Person.rb'
require './utilities.rb'
require './Logging.rb'

class Tests

  include Logging
  include Utilities

  attr_accessor :failed_tests, :passed_tests
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
    a = Person.new("Charlie Brown","09121966","New York","male")
    puts "//+++++++++++++ TEST: Create Person Instance +++++++++++++//"
    puts "Newly initialized person:"
    puts "Name: " << a.name
    puts "Birthdate: " << a.birthdate
    puts "Birthplace: " << a.birthplace
    puts "Gender: " << a.gender

    # Use setters to create person instance w/ same info
    b = Person.new("Charlie Brown","09121966","New York","male")
    c = Person.new("Psycho Killer","04011970","New Jersey","female")

    @instance_a = [a.name,a.birthdate,a.birthplace,a.gender]
    @instance_b = [b.name,b.birthdate,b.birthplace,b.gender]
    @instance_c = [c.name,c.birthdate,c.birthplace,c.gender]

    self.assert_equal(@instance_a,@instance_b)
    self.assert_not_equal(@instance_a,@instance_c)
  end

  def create_love_interest_instance
    # Use initialization to construct love interest instance:
    a = LoveInterest.new("Melissa Dooley","03121972","Los Angeles","female")
    puts "//+++++++++++++ TEST: Create Love Interest Instance +++++++++++++//"
    puts "Newly initialized love interest:"
    puts "Name: " << a.name
    puts "Birthdate: " << a.birthdate
    puts "Birthplace: " << a.birthplace
    puts "Gender: " << a.gender

    # Use setters to create person instance w/ same info
    b = LoveInterest.new("Melissa Dooley","03121972","Los Angeles","female")
    c = LoveInterest.new("Joan Baez","01011970","Boston","transgender")

    @instance_a = [a.name,a.birthdate,a.birthplace,a.gender]
    @instance_b = [b.name,b.birthdate,b.birthplace,b.gender]
    @instance_c = [c.name,c.birthdate,c.birthplace,c.gender]

    self.assert_equal(@instance_a,@instance_b)
    self.assert_not_equal(@instance_a,@instance_c)

    a.compatibility_score = 90
    c.compatibility_score = 40

    puts "//+++++++++++++ TEST: Compatibility Cut-off +++++++++++++//"
    self.assert_equal(a.is_compatible,true)
    self.assert_not_equal(c.is_compatible,true)
  end

  def kua_profile
    a = Person.new("Charlie Brown","09121966","New York","male")
    b = LoveInterest.new("Melissa Dooley","03121972","Los Angeles","female")
    c = LoveInterest.new("Indifferent Dodger","07011970","Miami","female")
    d = LoveInterest.new("Brain Wartscht","12241997","Cancun","female")
    e = Person.new("Riki Pretty","08271992","Tokyo","female")
    f = Person.new("Slim Pickings","05281942","Tokyo","male")

    kua_profile_a = Kua.new(a)
    kua_profile_b = Kua.new(b)
    kua_profile_c = Kua.new(c)
    kua_profile_d = Kua.new(d)
    kua_profile_e = Kua.new(e)
    kua_profile_f = Kua.new(f)

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
    a = Person.new("Slim Pickings","05281942","Tokyo","male")
    b = Person.new("Modest Mouse","02141946","Saitama","female")
    c = LoveInterest.new("Shirley Temple","01141901","Hollywood","female")
    d = LoveInterest.new("Maniac","01271974","Pittsboig","male")

    kua_profile_a = Kua.new(a)
    kua_profile_b = Kua.new(b)
    kua_profile_c = Kua.new(c)
    kua_profile_d = Kua.new(d)

    puts "//+++++++++++++ TEST: Birthdate is In Range +++++++++++++//"
    self.assert_equal(kua_profile_a.is_in_range,false)
    self.assert_equal(kua_profile_b.is_in_range,true)
    self.assert_equal(kua_profile_c.is_in_range,false)
    self.assert_equal(kua_profile_d.is_in_range,true)
  end

  def year_lookup_hash
    test_birthdate1 = '07041974'
    test_birthdate2 = '11232001'
    test_birthdate3 = '01141902'

    ans_1974 = "Jan 23 11:02"
    ans_2001 = "Jan 24 13:07"
    ans_1902 = "Jan 9 21:14"

    yr_hash1 = get_year_lookup_hash(test_birthdate1)
    yr_hash2 = get_year_lookup_hash(test_birthdate2)
    yr_hash3 = get_year_lookup_hash(test_birthdate3)

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

    # // ****** GROUP 1: Rooster ******     # Rooster - 1957-01-31 -> 1958-02-18
    person_charlie = Person.new("Charlie Brown","01241957","New York","male")
    kua_profile_charlie = Kua.new(person_charlie)

    love_melissa = LoveInterest.new("Melissa Dooley","01311957","Los Angeles","female")
    kua_profile_melissa = Kua.new(love_melissa)

    love_indiff = LoveInterest.new("Indifferent Dodger","02091957","Miami","female")
    kua_profile_indiff = Kua.new(love_indiff)

    love_wart = LoveInterest.new("Brain Wartscht","02181958","Cancun","female")
    kua_profile_wart = Kua.new(love_wart)

    # // ****** GROUP 2: Monkey ******     # Monkey - 2004-01-22 -> 2005-02-09
    person_bill = Person.new("Morris Bill","01212004","New York","male")
    kua_profile_bill = Kua.new(person_bill)

    love_sally = LoveInterest.new("Sally Mae","01222004","Los Angeles","female")
    kua_profile_sally = Kua.new(love_sally)

    love_unhappy = LoveInterest.new("Unhappy Camper","03122004","Miami","female")
    kua_profile_unhappy = Kua.new(love_unhappy)

    love_bertha = LoveInterest.new("Big Bertha","02082005","Cancun","female")
    kua_profile_bertha = Kua.new(love_bertha)

    puts "//+++++++++++++ TEST: Det Calendar Yr Beta +++++++++++++//"
    year_1 = kua_profile_charlie.calendar_yr_calc_beta(get_year_lookup_hash(person_charlie.birthdate))
    year_2 = kua_profile_melissa.calendar_yr_calc_beta(get_year_lookup_hash(love_melissa.birthdate))
    year_3 = kua_profile_indiff.calendar_yr_calc_beta(get_year_lookup_hash(love_indiff.birthdate))
    year_4 = kua_profile_wart.calendar_yr_calc_beta(get_year_lookup_hash(love_wart.birthdate))

    logger.debug "year 1957: " << year_1
    logger.debug "year 1957: " << year_2
    logger.debug "year 1957: " << year_3
    logger.debug "year 1958: " << year_4

    assert_equal(year_1,"1956")
    assert_equal(year_2,"1957")
    assert_equal(year_3,"1957")
    assert_equal(year_4,"1958")

    year_5 = kua_profile_bill.calendar_yr_calc_beta(get_year_lookup_hash(person_bill.birthdate))
    year_6 = kua_profile_sally.calendar_yr_calc_beta(get_year_lookup_hash(love_sally.birthdate))
    year_7 = kua_profile_unhappy.calendar_yr_calc_beta(get_year_lookup_hash(love_unhappy.birthdate))
    year_8 = kua_profile_bertha.calendar_yr_calc_beta(get_year_lookup_hash(love_bertha.birthdate))

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
    person_nutz = Person.new("Charlie Nutz","01121967","Seattle","female")
    kua_profile_nutz = Kua.new(person_nutz)
    puts "Profile details: " << kua_profile_nutz.details.to_s
    puts "Nutz's kua number is: " << kua_profile_nutz.kua_number
    puts "Nutz's group is: " << kua_profile_nutz.group

    assert_equal(kua_profile_nutz.kua_number, "8")
    assert_equal(kua_profile_nutz.group, "West")

    person_peace = Person.new("Jim Peace","02161984","Washington, DC","male")
    kua_profile_peace = Kua.new(person_peace)
    puts "Profile details: " << kua_profile_peace.details.to_s
    puts "Peace's kua number is: " << kua_profile_peace.kua_number
    puts "Peace's group is: " << kua_profile_peace.group

    assert_equal(kua_profile_peace.kua_number, "7")
    assert_equal(kua_profile_peace.group, "West")

    person_tomoko = Person.new("Tomoko Saito","12101973","Hiroshima","female")
    kua_profile_tomoko = Kua.new(person_tomoko)
    puts "Profile details: " << kua_profile_tomoko.details.to_s
    puts "Tomoko's kua number is: " << kua_profile_tomoko.kua_number
    puts "Tomoko's group is: " << kua_profile_tomoko.group

    assert_equal(kua_profile_tomoko.kua_number, "6")
    assert_equal(kua_profile_tomoko.group, "West")

    person_mitsuko = Person.new("Mitsuko","02111946","Matsuei","female")
    kua_profile_mitsuko = Kua.new(person_mitsuko)
    puts "Profile details: " << kua_profile_mitsuko.details.to_s
    puts "Mitsuko's kua number is: " << kua_profile_mitsuko.kua_number
    puts "Mitsuko's group is: " << kua_profile_mitsuko.group

    assert_equal(kua_profile_mitsuko.kua_number, "6")
    assert_equal(kua_profile_mitsuko.group, "West")

    person_kraw = Person.new("Jane Krakowski","10111968","Chicago","female")
    kua_profile_kraw = Kua.new(person_kraw)
    puts "Profile details: " << kua_profile_kraw.details.to_s
    puts "Jane's kua number is: " << kua_profile_kraw.kua_number
    puts "Jane's group is: " << kua_profile_kraw.group

    assert_equal(kua_profile_kraw.kua_number, "1")
    assert_equal(kua_profile_kraw.group, "East")
  end

  def run
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
