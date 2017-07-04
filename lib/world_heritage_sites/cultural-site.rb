require 'open-uri'
require 'pry'
require 'nokogiri'

class WorldHeritageSites::CulturalSite
  attr_accessor :name
  @@all = []

  def self.scrape_cultural_sites
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/?order=property&type=cultural'))
      doc.css("div.content").each do |boxes|
        boxes.css("div.list_site.box li.cultural a").each do |site|
          @@all << site.text
        end
      end
    @@all.map! {|element| element.gsub("*" , "")}
    @@all.map! {|element| element.gsub("#" , "")}
    @@all.delete_if { |element| element =~ /[0-9]/}
    @@all.delete_if { |element| element == ""}

    @@all
  end

  def self.all
    @@all
  end
end
