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
  
  # weeks of the calendar.
  #
  # @return [Array<Week>]
  def weeks
    a_date = self.first
    the_last = self.last
    weeks = []
    
    while (a_date < the_last)
      weeks << Koyomi::Week.new(a_date, self.week_start)
      a_date += WEEK_DAYS
    end
    weeks
  end
  
  # week day of nth week.
  #
  # @param  [Integer] nth
  # @param  [Object]  wday_name
  # @return [Date]
  def nth_wday(nth, wday_name)
    self.koyomi_month.nth_wday(nth, wday_name)
  end
  
  # week days
  #
  # @param  [Object]  wday_name
  # @return [Array<Date>]
  def wdays(wday_name)
    _wdays = []
    a_date = self.nth_wday(1, wday_name)
    while ((a_date.month == self.month))
      _wdays << a_date
      a_date += WEEK_DAYS
    end
    _wdays
  end
  
  # cycle dates
  #
  # @param  [Array<Integer>|Integer]  weeks
  # @param  [Array<Object>|Object]  wdays
  # @return [Array<Date>]
  def cycles(weeks, wdays)
    self.koyomi_month.cycles(weeks, wdays)
  end
  
  #--------------------#
  protected
  
  attr_writer :year, :month, :koyomi_month
end