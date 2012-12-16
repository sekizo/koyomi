# encoding: utf-8

require "date"
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
    self.created_at = Date.today
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
  
  #--------------------#
  protected
  
  attr_accessor :created_at
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
end