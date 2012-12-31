# encoding: utf-8

require "date"
require "koyomi/helper/init"
require "koyomi/helper/week"

class Date
  include Koyomi::Helper::Week
  
  # check week end?
  #
  # @param  [Object]  week_start
  # @return [Boolean]
  def week_end?(week_start = nil)
    self.class.week_ends?(self, week_start)
  end
  
  # check week start?
  #
  # @param  [Object]  week_start
  # @return [Boolean]
  def week_start?(week_start = nil)
    self.class.week_starts?(self, week_start)
  end
  
  # week day index
  #
  # @return [Integer]
  def windex
    self.class.windex(self)
  end
  
  # week day name
  #
  # @return [Symbol]
  def wday_name
    self.class.wday_name(self)
  end
  
  # nth week day of the month
  #
  # @return [Integer]
  def nth_month_week
    _week = (self.day / WEEK_DAYS).to_i
    _fraction = (self.day % WEEK_DAYS)
    (_week + (_fraction == 0 ? 0 : 1))
  end
  
  # nth week, week day of the month
  #
  # @return [Array] [<Integer>nth_month_week, <Symbol>wday_name]
  def nth_wday
    [self.nth_month_week, self.wday_name]
  end
  
  # monthly information
  #
  # @return [Hash]
  def month_info
    _info = {}
    _infos = self.nth_wday.dup
    _info[:nth] = _infos.shift
    _info[:wday] = _infos.shift
    
    _info
  end
end
