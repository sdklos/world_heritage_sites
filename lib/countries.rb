require 'open-uri'
require 'pry'
require 'nokogiri'

class Country
  attr_accessor :name
  @@all = []

  def self.scrape_countries
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/'))
    box = doc.css("div#acc.box")
    #doc.css("div#acc.box").each do |box|
      box.css("h4").each do |country|
        name = country.css("a").text
        @@countries << name
      end
      binding.pry
  end



end
