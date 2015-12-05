# encoding: utf-8

require "koyomi/period"

class Koyomi::Week < Koyomi::Period
  #--------------------#
  # constants

  DEFAULT_START = :mon
  WDAYS = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
  DAYS = WDAYS.size
  START_RANGE = (0..(DAYS - 1))

  #--------------------#
  # attributes

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
      raise "Range invalid, required #{WDAYS}." unless WDAYS.include?(value)
      index = WDAYS.index(value)
    else
      index = value.to_s.to_i
    end
    raise "Range overflow, required (#{START_RANGE})." unless START_RANGE.cover?(index)
    index
  end

  # week day name
  #
  # @param  [Object]  value
  # @return [Symbol]
  def self.wday_name(value)
    WDAYS.at(self.windex(value))
  end

  # week starts?
  #
  # @param  [Date]  date
  # @param  [Object]  start_wday  week start
  # @return [Boolean]
  def self.starts?(date, start_wday = DEFAULT_START)
    (date).wday == self.windex(start_wday)
  end

  # week end?
  #
  # @param  [Date]  date
  # @param  [Object]  start_wday  week start
  # @return [Boolean]
  def self.ends?(date, start_wday = DEFAULT_START)
    (date + 1).wday == self.windex(start_wday)
  end

  #--------------------#
  # instance methods

  # initialize method
  #
  # @param  [Date]  date optional, default use Date.today.
  # @param  [Object]  start_wday  optionail, default use Koyomi::Week::DEFAULT_START
  def initialize(date = nil, start_wday = DEFAULT_START)
    super()
    @start_wday = start_wday
    setup_range(date||created_at)
  end

  # sepified week day
  #
  # @param  [Object]  wday_name
  # @return [Date]
  def wday(wday_name)
    diff = self.class.windex(wday_name) - self.class.windex(self.start_wday)
    factor = diff + ((diff < 0) ? DAYS : 0)
    first + factor
  end

  alias_method :starts, :first
  alias_method :ends,   :last

  #--------------------#
  protected

  attr_reader :start_wday

  #--------------------#
  private

  # setup week range with given week start
  def setup_range(date)
    diff = date.wday - self.class.windex(start_wday)
    @first  = date - (diff + ((diff < 0) ? DAYS : 0))
    @last   = @first + DAYS - 1
  end

  def method_missing(name, *args, &block)
    case
    when WDAYS.include?(name.to_s.to_sym)
      self.wday(name,*args, &block)
    else
      super
    end
  end
end
