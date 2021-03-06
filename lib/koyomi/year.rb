# encoding: utf-8

require "koyomi/period"

class Koyomi::Year < Koyomi::Period
  #--------------------#
  # class methods

  # create instance from date
  #
  # @param  [Date]  date
  # @return [Koyomi::Year]
  def self.of(date = Date.today)
    self.new(date.year)
  end

  #--------------------#
  # instance methods

  attr_reader :year

  # initialize instance.
  #
  # @param  [Integer] year  optional, default use the year of instance created.
  def initialize(year = nil)
    super()
    @year   = year||created_at.year
    @first  = Date.new(@year,  1,  1)
    @last   = Date.new(@year, 12, 31)
  end

  (1..12).each do |m|
    define_method("_#{m}") do
      Koyomi::Month.new(m, year)
    end
  end

  def month(month)
    Koyomi::Month.new(month, year)
  end

  def uruu?
    begin
      Date.new(year, 2, 29)
    rescue ArgumentError => e
      false
    else
      true
    end
  end
  alias_method :leap?, :uruu?
end
