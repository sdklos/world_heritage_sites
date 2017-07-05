require 'open-uri'
require 'pry'
require 'nokogiri'

class WorldHeritageSites::Country
  @@all = []

  def initialize
  end

  def self.scrape_countries
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/'))
    box = doc.css("div#acc.box")
      box.css("h4").each do |country|
        @@all << country.css("a").text
      end
      binding.pry
    @@all
  end

  def scrape_country
    @all = []
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/'))
    doc.css("div#acc.box").each do |box|
    box.css(".list_site li.cultural_danger").each do |place|
        @all << place.css("a").text
    end
      binding.pry
    @all
  end

      #list of places not divided by country
      #(".list_site li.cultural_danger")
  end

  def scrape_site_by_country
      doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/'))
      box = doc.css("div#acc.box")
      country = box.css("h4 a.text")
      site = box.css(".list_site li.cultural_danger a").text
      binding.pry

      #h4 and .list_site alternate; each site is within li.cultural_danger
  end

  def self.all
    @@all
    binding.pry
  end
end
