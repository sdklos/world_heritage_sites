require 'open-uri'
require 'pry'
require 'nokogiri'

class WorldHeritageSites::NaturalSite

  def self.scrape_natural_sites
    all = []
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/?order=property&type=natural'))
      doc.css("div.content").each do |boxes|
        boxes.css("div.list_site.box li.natural a").each do |site|
          all << site.text
        end
      end
    all.map! {|element| element.gsub("*" , "")}
    all.map! {|element| element.gsub("#" , "")}
    all.delete_if { |element| element =~ /[0-9]/}
    all.delete_if { |element| element == ""}

    all
  end
end
