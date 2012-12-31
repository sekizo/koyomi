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
  attr_accessor :week_start
  attr_reader :year, :month, :koyomi_month
  attr_reader :weeks
    
  # initialize instance
  #
  # @param  [Integer] year optional, use instance create date.
  # @param  [Integer] month optional, use instance create date.
  # @param  [Object] week_start weekday which week starts with. optional, use DEFAULT_WEEK_START.
  def initialize(year = nil, month = nil, week_start = nil)
    super()
    self.year = year||self.created_at.year
    self.month = month||self.created_at.month
    self.koyomi_month = Koyomi::Month.new(self.month, self.year)
    self.week_start = week_start||DEFAULT_WEEK_START
  end
  
  # set week_start
  #
  # @param  [Object]  value
  def week_start=(value)
    self.setup_week_start(value)
    @week_start
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
  
  # week day of nth week.
  #
  # @param  [Integer] nth
  # @param  [Object]  wday_name
  # @return [Date]
  def nth_wday(nth, wday_name)
    self.weeks[nth - 1].wday(wday_name)
  end
  
  # week days
  #
  # @param  [Object]  wday_name
  # @return [Array<Date>]
  def wdays(wday_name)
    self.weeks.collect { |w| w.wday(wday_name) }
  end
  
  # cycle dates
  #
  # @param  [Array<Integer>|Integer]  weeks
  # @param  [Array<Object>|Object]  wdays
  # @return [Array<Date>]
  def cycles(weeks, wdays)
    _dates = []
    cycle_weeks_filter(weeks).each do |n|
      [wdays].flatten.each do |w|
        _dates << self.nth_wday(n, w)
      end
    end
    _dates.sort
  end
  
  #--------------------#
  protected
  
  attr_writer :year, :month, :koyomi_month
  
  # setup week start
  #
  # @param  [Object]  value
  def setup_week_start(value)
    @week_start = self.class.windex(value)
    self.setup_weeks(@week_start)
  end
  
  # setup weeks of the calendar.
  #
  # @return [Array<Week>]
  def setup_weeks(week_start)
    a_date = self.first
    the_last = self.last
    @weeks = []
    
    while (a_date < the_last)
      @weeks << Koyomi::Week.new(a_date, week_start)
      a_date += WEEK_DAYS
    end
    @weeks
  end
  
  #--------------------#
  private
  
  # cycle weeks filter
  #
  # @param  [Object]  weeks
  # @return [Iterator]  Array or Range
  def cycle_weeks_filter(weeks)
    case
    when weeks.to_s =~ /every/
      (1..self.weeks.size)
    else
      [weeks].flatten
    end
  end
end
