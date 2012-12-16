# encoding: utf-8

require "date"
require "koyomi/calendar"

module Koyomi::Helper::Date
  # check week end?
  #
  # @param  [Date]  date
  # @param  [Object]  week_start
  # @return [Boolean]
  def week_ends?(date, week_start = nil)
    wdays = Koyomi::Calendar::WEEK_DAYS
    week_start ||= Koyomi::Calendar::DEFAULT_WEEK_START
    week_ends = (Koyomi::Calendar.windex(week_start) + wdays - 1) % wdays
    date.wday == week_ends
  end
end

class Date
  include Koyomi::Helper::Date
  
  # check week end?
  #
  # @param  [Object]  week_start
  # @return [Boolean]
  def week_end?(week_start = nil)
    week_ends?(self, week_start)
  end
end
