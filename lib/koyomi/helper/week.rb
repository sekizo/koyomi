# encoding: utf-8

require "koyomi/helper/init"
require "koyomi/week"

module Koyomi::Helper::Week
  DEFAULT_WEEK_START = Koyomi::Week::DEFAULT_START
  WEEK_WDAYS = Koyomi::Week::WDAYS
  WEEK_DAYS = Koyomi::Week::DAYS
  WEEK_START_RANGE = Koyomi::Week::START_RANGE
  
  def self.included(mod)
    mod.class_eval do
      extend Koyomi::Helper::Week::ClassMethod
    end
  end
  
  module ClassMethod
    # week index
    #
    # @param  [Object]  value
    # @return [Integer]
    def windex(value)
      Koyomi::Week.windex(value)
    end
    
    # week day name
    #
    # @param  [Object]  value
    # @return [Symbol]
    def wday_name(value)
      Koyomi::Week.wday_name(value)
    end
    
    # week end?
    #
    # @param  [Date]  date
    # @param  [Object]  week_start  week start
    # @return [Boolean]
    def week_ends?(date, week_start = nil)
      Koyomi::Week.ends?(date, week_start)
    end
  end
end
