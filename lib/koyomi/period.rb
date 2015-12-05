# encoding: utf-8

require "date"

class Koyomi::Period
  attr_reader :first, :last

  #--------------------#
  # instance methods

  def initialize(first = nil, last = nil)
    super()
    @created_at = Date.today
    @first = first||@created_at
    @last = last||@created_at
  end

  def range
    (first .. last)
  end

  #--------------------#
  private

  attr_reader :created_at

  # throw uniplemeted method to self range.
  def method_missing(name, *args, &block)
    begin
      self.range.__send__(name, *args, &block)
    rescue => e
      super
    end
  end
end
