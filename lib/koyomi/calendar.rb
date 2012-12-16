# encoding: utf-8

require "koyomi/period"
require "koyomi/month"

class Koyomi::Calendar < Koyomi::Period
  #--------------------#
  # constant
  DEFAULT_WEEK_START = :mon
  WEEK_START_RANGE = (0..6)
  WEEK_START_STRING = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
  
  #--------------------#
  # class methods
  
  # week index
  #
  # @param  [Object]  value
  # @return [Integer]
  def self.windex(value)
    case value
    when Numeric
      index = value
    when Date
      index = value.wday
    when String, Symbol
      value = value.to_s.downcase[0, 3].to_sym
      raise "Range invalid, required #{WEEK_START_STRING}." unless WEEK_START_STRING.include?(value)
      index = WEEK_START_STRING.index(value)
    else
      index = value.to_s.to_i
    end
    raise "Range overflow, required (#{WEEK_START_RANGE})." unless WEEK_START_RANGE.cover?(index)
    index
  end
  
  # week label
  #
  # @param  [Object]  value
  # @return [Symbol]
  def self.wlabel(value)
    WEEK_START_STRING.at(self.windex(value))
  end
  
  #--------------------#
  # instance methods
  attr_reader :year, :month, :koyomi_month
  attr_accessor :week_start
  
  # initialize instance
  #
  # @param  [Integer] year optional, use instance create date.
  # @param  [Integer] month optional, use instance create date.
  # @param  [Object] week_start weekday which week starts with. optional, use 1 (Monday).
  def initialize(year = nil, month = nil, week_start = nil)
    super()
    self.year = year||self.created_at.year
    self.month = month||self.created_at.month
    self.week_start = week_start||self.class::DEFAULT_WEEK_START
    
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
    week_starts(self.koyomi_month.first, self.week_start)
  end
  
  # last date of the calendar (NOT last date of the MONTH)
  #
  # @return [Date]
  def last
    week_ends(self.koyomi_month.last, self.week_start)
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
  
  #--------------------#
  private
  
  def week_starts(date, week_start = nil)
    week_start ||= self.week_start
    diff = date.wday - week_start
    sd = date - diff
    sd -= diff < 0 ? 7 : 0
    sd
  end
  
  def week_ends(date, week_start = nil)
    week_starts(date, week_start) + 6
  end
end