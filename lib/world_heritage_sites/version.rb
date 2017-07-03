require 'open-uri'
require 'pry'
require 'nokogiri'

module WorldHeritageSites
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end



  def countries
    @countries
  end

end
end
