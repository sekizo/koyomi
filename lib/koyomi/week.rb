# encoding: utf-8

require "koyomi/period"
require "koyomi/calendar"

class Koyomi::Week < Koyomi::Period
  #--------------------#
  # constant
  
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
  
  #--------------------#
  # instance methods
  
  # initialize method
  #
  # @param  [Date]  date optional, default use Date.today.
  # @param  [Object]  start_wday  optionail, default use Koyomi::Week::DEFAULT_START
  def initialize(date = nil, start_wday = nil)
    super()
    self.date = date||self.created_at
    self.start_wday = start_wday||DEFAULT_START
  end
  
  #--------------------#
  protected
  
  attr_accessor :date
  attr_reader :start_wday
  
  def start_wday=(value)
    @start_wday = value
    self.setup_range
    @start_wday
  end
  
  def setup_range
    diff = self.date.wday - self.class.windex(self.start_wday)
    starts = self.date - (diff + ((diff < 0) ? DAYS : 0))
    @range = Range.new(starts, starts + DAYS - 1)
  end
end

module Koyomi
  DEFAULT_WEEK_START = Koyomi::Week::DEFAULT_START
  WEEK_WDAYS = Koyomi::Week::WDAYS
  WEEK_DAYS = Koyomi::Week::DAYS
  WEEK_START_RANGE = Koyomi::Week::START_RANGE
end
