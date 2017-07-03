# Our CLI Controller

require 'open-uri'
require 'pry'
require 'nokogiri'

class WorldHeritageSites::CLI

  def call
    input = ""
    while input != "exit"
      puts "Welcome to the World Heritage Sites Database"
      puts "To get a list of countries enter 'list countries'."
      puts "To get a list of sites enter 'list sites'."
      puts "To get a list of cultural sites enter 'list cultural sites'"
      puts "To get a list of natural sites enter 'natural sites'"
      puts "To quit, type 'exit'"
      puts "What would you like to do?"
      input = gets.strip.downcase
      case input
      when "list countries"
        list_countries
        # puts "Which country's sites would you like to view?"
        # input = gets.strip.downcase
      when "list sites"
        list_sites
      when "list cultural sites"
        list_cultural_sites
      when "list natural sites"
        list_natural_sites
      end
    end
  end

  def list_countries
    list = Country.all
    list.each do |country|
      puts "#{country.upcase}"
    end
  end


end
