# encoding: utf-8

require "koyomi/period"
require "koyomi/month"

class Koyomi::Calendar < Koyomi::Period
  #--------------------#
  # constant
  DEFAULT_WEEK_START = 0
  WEEK_START_RANGE = (0..6)
  WEEK_START_STRING = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
  
  #--------------------#
  # instance methods
  attr_reader :year, :month, :koyomi_month
  attr_reader :first, :last
  attr_accessor :week_start
  
  def initialize(year = nil, month = nil, week_start = nil)
    super()
    self.range = self.initialize_range(year, month, week_start)
  end
  
  def week_start=(value)
    case value
    when Numeric
      klass = :numeric
    when String, Symbol
      klass = :string
    else
      klass = value.class.name
    end
    
    m = "week_start_as_#{klass.to_s.downcase}"
    @week_start = self.__send__(m, value)
  end
  
  #--------------------#
  protected
  
  attr_writer :year, :month, :koyomi_month
  attr_writer :first, :last
  
  def initialize_range(year = nil, month = nil, week_start = nil)
    self.year = year||self.created_at.year
    self.month = month||self.created_at.month
    self.koyomi_month = Koyomi::Month.new(self.month, self.year)
    self.week_start = week_start||self.class::DEFAULT_WEEK_START
    
    self.first = week_starts(self.koyomi_month.first, self.week_start)
    self.last = week_ends(self.koyomi_month.last, self.week_start)
    
    Range.new(self.first, self.last)
  end
  
  #--------------------#
  private
  
  def week_start_as_numeric(value)
    raise "Range overflow, required (#{WEEK_START_RANGE})." unless WEEK_START_RANGE.cover?(value)
    value
  end
  
  def week_start_as_string(value)
    value = value.to_s.downcase[0, 3].to_sym
    raise "Range invalid, required #{WEEK_START_STRING}." unless WEEK_START_STRING.include?(value)
    WEEK_START_STRING.index(value)
  end
  
  def week_starts(date, week_start = nil)
    week_start ||= DEFAULT_WEEK_START
    diff = date.wday - week_start
    sd = date - diff
    sd -= diff < 0 ? 7 : 0
    sd
  end
  
  def week_ends(date, week_start = nil)
    week_start ||= DEFAULT_WEEK_START
    diff = date.wday - week_start
    sd = date - diff
    sd += diff < 0 ? 7 : 0
    sd    
  end
  

  
end