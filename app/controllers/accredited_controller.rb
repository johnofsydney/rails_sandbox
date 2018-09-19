class AccreditedController < ApplicationController
  require 'nokogiri'
  require 'pry'

  def show
    base_url = 'https://www.fertilitysociety.com.au/rtac/accredited-units/'
    @clinics = []

    states = ['act/', 'nsw/', 'nt/', 'nz/', 'qld-2/', 'sa-2/', 'tas-2/', 'vic/', 'wa-2/']

    states.each do |state|
      page = Nokogiri::HTML(open(base_url + state))
      # cells = page.css('tr td')
      rows = page.css('tr')
      # binding.pry

      rows.each do |row|
        name = row.children[1].css("h3").text
        address = row.children[1].css("h4").text.split("\n").join("") + row.children[1].css("p").text.split("\n").join(", ")
        # number = row.children[3].css("p").children.children.text
        number = row.children[3].children.text.gsub("\n", "")
        # doctor = row.children[5].css("p").text
        doctor = row.children[5].children.text

        clinic = {
          :name => name,
          :address => address,
          :number => number,
          :doctor => doctor
        }

        @clinics << clinic unless clinic[:name] == ""


      end

      # binding.pry
    end




    # binding.pry
    # raise
  end
end



require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
BASE_URL = 'https://www.realestate.com.au/'
BASE_DIR = 'sold/property-house-in-bondi/list-'
LOCAL_DIR = 'dump'

# https://www.realestate.com.au/sold/in-bondi%3b/list-1
# https://www.realestate.com.au/sold/property-house-in-bondi/list-1

FileUtils.makedirs(LOCAL_DIR) unless File.exists?LOCAL_DIR

# get metainfo from first page:
page = Nokogiri::HTML(open(BASE_URL+BASE_DIR + '1'))
last_page_number = 3


# write the HTML for page 1 to disk
# File.open("#{LOCAL_DIR}/all.html", 'w'){|f| f.write(page.css('.property-price'))}



puts "Iterating from 1 to #{last_page_number}"

for pg_number in 1..last_page_number do
  puts "Getting #{pg_number}"
  File.open("#{LOCAL_DIR}/all.html", 'w') do |f|
    # This writes the prices
    # f.write( Nokogiri::HTML(open(BASE_URL+BASE_DIR + "#{pg_number}")).css('.property-price'));
    #This writes all info
    f.write( Nokogiri::HTML(open(BASE_URL+BASE_DIR + "#{pg_number}")).css('.residential-card__content'))





  end
end

# .5r7jwc6vfo.3.1.3.1:$2013521375.0.1.1.0.0
# .5r7jwc6vfo.3.1.3.1:$2013527937.0.1.1.0.0
