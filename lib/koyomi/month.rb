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

  # a date next month of the date
  #
  # @param  [Date]  date
  # @return [Date]
  def self.a_date_of_next_month(date)
    date + 32
  end

  # first date of next month
  #
  # @param  [Date]  date
  # @return [Date]
  def self.first_date_of_next_month(date)
    a_date = self.a_date_of_next_month(date)
    Date.new(a_date.year, a_date.month, 1)
  end

  #--------------------#
  # instance methods

  attr_reader :year, :month

  # initialize instance.
  #
  # @param  [Integer] month optional, default use the month of instance created.
  # @param  [Integer] year  optional, default use the year of instance created.
  def initialize(month = nil, year = nil)
    @year   = year||created_at.year
    @month  = month||created_at.month
    _first  = Date.new(@year, @month, 1)
    _last   = (self.class.first_date_of_next_month(_first) - 1)
    super(_first, _last)
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

  # Create Koyomi::Calendar
  #
  # @param  [Object]  week_start
  # @return [Koyomi::Calendar]
  def calendar(week_start = Koyomi::Week::DEFAULT_START)
    Koyomi::Calendar.new(year, month, week_start)
  end

  # Create Koyomi::MonthCycle
  #
  # @return [Koyomi::Cycle]
  def cycle
    Koyomi::MonthCycle.new(self)
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
        begin
          a_date = self.nth_wday!(n, w)
        rescue Koyomi::WrongRangeError => e
          next
        else
          _dates << a_date
        end
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
    case "#{nth}"
    when /first/
      calc_nth_wday(1, wday_name)
    when /last/
      self.next.nth_wday(1, wday_name) - Koyomi::Week::DAYS
    else
      calc_nth_wday(nth, wday_name)
    end
  end

  # week day of nth week.
  #
  # @param  [Integer] nth
  # @param  [Object]  wday_name
  # @return [Date]
  def nth_wday!(nth, wday_name)
    date = nth_wday(nth, wday_name)
    raise Koyomi::WrongRangeError if date.month != self.month
    date
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

  # date
  #
  # @param [Integer] days
  # @return [Date]
  def date(day)
    begin
      date!(day)
    rescue ArgumentError => e
      raise Koyomi::WrongRangeError
    end
  end

  # date
  #   don't catch exceptions
  #
  # @param [Integer] days
  # @return [Date]
  def date!(day)
    Date.new(self.year, self.month, "#{day}".to_i)
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

  # maximumn of weeks
  #
  # @return [Integer]
  def max_week
    _weeks = (self.last.day / Koyomi::Week::DAYS).to_i
    _fraction = (self.last.day % Koyomi::Week::DAYS)
    (_weeks + (_fraction == 0 ? 0 : 1))
  end

  def calc_nth_wday(nth, wday_name)
    a_date = self.first + ((nth - 1) * Koyomi::Week::DAYS)
    Koyomi::Week.new(a_date, a_date.wday).wday(wday_name)
  end

  def method_missing(name, *args, &block)
    date("#{name}".sub(/^_/, "")) if "#{name}".match(/^_[0-9]+$/)
  end
end
