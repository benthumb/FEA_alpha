require 'nokogiri'
require 'open-uri'

# Get a Nokogiri::HTML::Document for the page we’re interested in...

doc = Nokogiri::HTML(open("./data/phases2001.html"))
#doc = Nokogiri::HTML(open("./data/phases1901.html"))

# Do funky things with it using Nokogiri::XML::Node methods...

####
# Search for nodes by xpath
puts doc.text

