# encoding: utf-8

require "koyomi/period"
require "koyomi/month"
require "koyomi/helper/week"

class Koyomi::Calendar < Koyomi::Period
  include Koyomi::Helper::Week
  
  # create Koyomi::Calendar instance from date.
  #
  # @param  [Date]  date
  # @param  [Object]  week_start
  # @return [Koyomi::Calendar]
  def self.of(date, week_start = nil)
    self.new(date.year, date.month, week_start)
  end
  
  #--------------------#
  # instance methods
  attr_reader :year, :month, :koyomi_month
  attr_accessor :week_start
  
  # initialize instance
  #
  # @param  [Integer] year optional, use instance create date.
  # @param  [Integer] month optional, use instance create date.
  # @param  [Object] week_start weekday which week starts with. optional, use DEFAULT_WEEK_START.
  def initialize(year = nil, month = nil, week_start = nil)
    super()
    self.year = year||self.created_at.year
    self.month = month||self.created_at.month
    self.week_start = week_start||DEFAULT_WEEK_START
    
    self.koyomi_month = Koyomi::Month.new(self.month, self.year)
  end
  
  # set week_start
  #
  # @param  [Object]  value
  def week_start=(value)
    @week_start = self.class.windex(value)
  end
  
  # first date of the calendar (NOT first date of the MONTH)
  #
  # @return [Date]
  def first
    Koyomi::Week.new(self.koyomi_month.first, self.week_start).first
  end
  
  # last date of the calendar (NOT last date of the MONTH)
  #
  # @return [Date]
  def last
    Koyomi::Week.new(self.koyomi_month.last, self.week_start).last
  end
  
  # range of the calendar.
  #
  # @return [Range]
  def range
    Range.new(self.first, self.last)
  end
  
  # Koyomi::Month of the calendar's month.
  #
  # @return [Koyomi::Month]
  def the_month
    self.koyomi_month
  end
  
  #--------------------#
  protected
  
  attr_writer :year, :month, :koyomi_month
end