# Our CLI Controller

require 'open-uri'
require 'pry'
require 'nokogiri'

class WorldHeritageSites::CLI

  def call
    input = ""
    while input != "exit"
      puts "Welcome to the World Heritage Sites Database"
      puts "To get a list of cultural sites enter 'list cultural sites'"
      puts "To get a list of natural sites enter 'list natural sites'"
      puts "To get a list of mixed natural and cultural sites enter 'list mixed sites'"
      puts "To quit, type 'exit'"
      puts "What would you like to do?"
      input = gets.strip.downcase
      case input
      when "list cultural sites"
        list_cultural_sites
        cultural_sites_list_menu
      when "list natural sites"
        list_natural_sites
        natural_sites_list_menu
      when "list mixed sites"
        list_mixed_sites
        mixed_sites_list_menu
      end
    end
  end

  def list_cultural_sites
    WorldHeritageSites::CulturalSite.scrape_cultural_sites.each.with_index(1) do |site, index|
      puts "#{index}. #{site}"
    end
  end

  def cultural_sites_list_menu
    list = WorldHeritageSites::CulturalSite.scrape_cultural_sites
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/?order=property&type=cultural'))
    boxes = doc.css("div.ym-gbox-left")
    site = boxes.css("div.list_site.box li a")
    name = boxes.css("div.list_site.box li a").text
    puts "Which site would you like to learn more about? (enter site name)"
    input = gets.strip
    if site.detect {|content| content.text.downcase.include?(input.downcase)}
      url = ""
      result = []
      result = site.detect {|content| content.text.downcase.include?(input.downcase)}
      url = "http://whc.unesco.org#{result.attribute('href').value}"
      description = Nokogiri::HTML(open(url))
      synopsis = description.css("div.ym-gbox-left.readable div.box")
      synopsis[2].css("p").each do |paragraph|
        puts "", paragraph.text, ""
      end
    else
      puts "Please enter a valid site name"
      cultural_sites_list_menu
    end
  end

  def list_natural_sites
    WorldHeritageSites::NaturalSite.scrape_natural_sites.each.with_index(1) do |site, index|
      puts "#{index}. #{site}"
    end
  end

  def natural_sites_list_menu
    list = WorldHeritageSites::NaturalSite.scrape_natural_sites
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/?order=property&type=natural'))
    boxes = doc.css("div.ym-gbox-left")
    site = boxes.css("div.list_site.box li a")
    name = boxes.css("div.list_site.box li a").text
    puts "Which site would you like to learn more about? (enter site name)"
    input = gets.strip
    if site.detect {|content| content.text.downcase.include?(input.downcase)}
      url = ""
      result = []
      result = site.detect {|content| content.text.downcase.include?(input.downcase)}
      url = "http://whc.unesco.org#{result.attribute('href').value}"
      description = Nokogiri::HTML(open(url))
      synopsis = description.css("div.ym-gbox-left.readable div.box")
      synopsis[2].css("p").each do |paragraph|
        puts "", paragraph.text, ""
      end
    else
      puts "Please enter a valid site name"
      natural_sites_list_menu
    end
  end

  def list_mixed_sites
    WorldHeritageSites::MixedSite.scrape_mixed_sites.each.with_index(1) do |site, index|
      puts "#{index}. #{site}"
    end
  end

  def mixed_sites_list_menu
    list = WorldHeritageSites::MixedSite.scrape_mixed_sites
    doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/?order=property&type=mixed'))
    boxes = doc.css("div.ym-gbox-left")
    site = boxes.css("div.list_site.box li a")
    name = boxes.css("div.list_site.box li a").text
    puts "Which site would you like to learn more about? (enter site name)"
    input = gets.strip
    if site.detect {|content| content.text.downcase.include?(input.downcase)}
      url = ""
      result = []
      result = site.detect {|content| content.text.downcase.include?(input.downcase)}
      url = "http://whc.unesco.org#{result.attribute('href').value}"
      description = Nokogiri::HTML(open(url))
      synopsis = description.css("div.ym-gbox-left.readable div.box")
      synopsis[2].css("p").each do |paragraph|
        puts "", paragraph.text, ""
      end
    else
      puts "Please enter a valid site name"
      mixed_sites_list_menu
    end
  end


end
