require 'open-uri'
require 'pry'
require 'nokogiri'

class WorldHeritageSites::Country
  attr_accessor :name
  @@all = []

  def self.scrape_countries
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/'))
    box = doc.css("div#acc.box")
      box.css("h4").each do |country|
        @@all << country.css("a").text
      end
    @@all
  end

  def self.all
    @@all
    binding.pry
  end
end
