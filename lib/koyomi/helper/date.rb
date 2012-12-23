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
end
