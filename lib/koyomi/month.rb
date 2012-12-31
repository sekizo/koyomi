# encoding: utf-8

require "koyomi/period"

class Koyomi::Month < Koyomi::Period
  
  #--------------------#
  # class methods
  
  # create instance from date
  #
  # @param  [Date]  date
  # @return [Koyomi::Month]
  def self.of(date)
    self.new(date.month, date.year)
  end
  
  #--------------------#
  # instance methods
  
  attr_reader :year, :month
  attr_reader :first, :last
  
  # initialize instance.
  #
  # @param  [Integer] month optional, default use the month of instance created.
  # @param  [Integer] year  optional, default use the year of instance created.
  def initialize(month = nil, year = nil)
    super()
    self.range = self.initialize_range(month, year) 
  end
  
  # next month
  #
  # @return [Koyomi::Month]
  def next
    self.class.of(self.last + 1)
  end
  
  # previous month
  #
  # @return [Koyomi::Month]
  def prev
    self.class.of(self.first - 1)
  end
  
  # week days of nth weeks.
  #
  # @param  [Integer|Array<Integer>] nth
  # @param  [Object|Array<Object>]  wday_name
  # @return [Array<Date>]
  def cycles(weeks, wdays)
    _dates = []
    cycle_weeks_filter(weeks).each do |n|
      [wdays].flatten.each do |w|
        a_date = self.nth_wday(n, w)
        _dates << a_date if a_date.month == self.month
      end
    end
    _dates.sort
  end
  
  # week day of nth week.
  #
  # @param  [Integer] nth
  # @param  [Object]  wday_name
  # @return [Date]
  def nth_wday(nth, wday_name)
    a_date = Date.new(self.year, self.month, 1) + ((nth - 1) * Koyomi::Week::DAYS)
    Koyomi::Week.new(a_date, a_date.wday).wday(wday_name)
  end
  
  
  # week days
  #
  # @param  [Object]  wday_name
  # @return [Array<Date>]
  def wdays(wday_name)
    _dates = []
    a_date = self.nth_wday(1, wday_name)
    
    while (a_date.month == self.month)
      _dates << a_date
      a_date += Koyomi::Week::DAYS
    end
    _dates.sort
  end
  
  #--------------------#
  protected
  
  attr_writer :year, :month
  attr_writer :first, :last
  
  # initialize range
  #
  # @param  [Integer] month optional, default use the month of instance created.
  # @param  [Integer] year  optional, default use the year of instance created.
  # @return [Range]
  def initialize_range(month = nil, year = nil)
    self.year = year||self.created_at.year
    self.month = month||self.created_at.month
    self.first = Date.new(self.year, self.month, 1)
    self.last = (first_date_next_month(self.first) - 1)
    Range.new(self.first, self.last)
  end
  
  #--------------------#
  private
  
  # filter cycle weeks
  #
  # @param  [Object]  weeks
  # @return [Array|Range]
  def cycle_weeks_filter(weeks)
    case
    when weeks.to_s =~ /every/
      _weeks = (1..max_week)
    else
      _weeks = [weeks].flatten
    end
    _weeks
  end
  
  # a date next month of the date
  #
  # @param  [Date]  date
  # @return [Date]
  def a_date_next_month(date)
    Date.new(date.year, date.month, 1) + 32
  end
  
  # first date of next month
  #
  # @param  [Date]  date
  # @return [Date]
  def first_date_next_month(date)
    a_date = a_date_next_month(date)
    Date.new(a_date.year, a_date.month, 1)
  end
  
  # maximumn of weeks
  #
  # @return [Integer]
  def max_week
    _weeks = (self.last.day / Koyomi::Week::DAYS).to_i
    _fraction = (self.last.day % Koyomi::Week::DAYS)
    (_weeks + (_fraction == 0 ? 0 : 1))
  end
end