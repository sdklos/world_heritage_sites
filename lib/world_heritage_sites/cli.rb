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
      input = gets.strip
      case input
      # when "list countries"
      #   list_countries
      #   #countries_list_menu
      #   # puts "Which country's sites would you like to view?"
      #   # input = gets.strip.downcase
      # # when "list sites"
      # #   list_sites
      # #   sites_list_menu
      when "list cultural sites"
        list_cultural_sites
        cultural_sites_list_menu
      when "list natural sites"
        list_natural_sites
        #natural_sites_list_menu
        #or just sites_list_menu?
      when "list mixed sites"
        list_mixed_sites
      end
    end
  end

  # def play_song
  # list = Song.all.sort{|a,b| a.name <=> b.name}
  #   puts "Which song number would you like to play?"
  #   input = gets.strip
  #   if input.to_i.between?(1,list.size)
  #     puts "Playing #{list[input.to_i-1].name} by #{list[input.to_i-1].artist.name}"
  #   end
  # #s  binding.pry
  # end

  # def list_countries
  #   WorldHeritageSites::Country.scrape_countries.each.with_index(1) do |country, index|
  #     puts "#{index}. #{country}"
  #   end
  # end

  # def countries_list_menu
  #   # list = WorldHeritageSites::Country.scrape_countries
  #   #    puts "Which country's sites would you like to view? (enter country's list number)"
  #   #    input = gets.strip
  #   #    if input.to_i.between?(1,list.size)
  #   #       list[input.to_i-1]
  #     # end
  # end

  # def sites_list_menu
  #
  # end

  def list_cultural_sites
    WorldHeritageSites::CulturalSite.scrape_cultural_sites.each.with_index(1) do |site, index|
      puts "#{index}. #{site}"
    end
  end

  def cultural_sites_list_menu
    list = WorldHeritageSites::CulturalSite.scrape_cultural_sites
    puts "Which site would you like to learn more about? (enter site's list number)"
    input = gets.strip
    if input.to_i.between?(1,list.size)
      doc = Nokogiri::HTML(open('http://whc.unesco.org/en/list/?order=property&type=cultural'))
      box = doc.css("div.ym-gbox-left")
      site = box.css("div.list_site.box li a")
      url = "http://whc.unesco.org#{site[input.to_i-1].attribute('href').value}"
      description = Nokogiri::HTML(open(url))
      synopsis = description.css("div.ym-gbox-left.readable div.box")
      synopsis[2].css("p").each do |paragraph|
        puts paragraph.text, ""

        ##tomorrow fix this - search through boxes.css("div.list_site.box li a") for the right text and return url that way
      end
    end
  end

  def list_natural_sites
    WorldHeritageSites::NaturalSite.scrape_natural_sites.each.with_index(1) do |site, index|
      puts "#{index}. #{site}"
    end
  end

  def natural_sites_list_menu

  end

  def list_mixed_sites
    WorldHeritageSites::MixedSite.scrape_mixed_sites.each.with_index(1) do |site, index|
      puts "#{index}. #{site}"
    end
  end


end
