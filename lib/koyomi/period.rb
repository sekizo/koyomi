# encoding: utf-8

require "date"

class Koyomi::Period
  attr_reader :first, :last

  #--------------------#
  # instance methods

  def initialize(first, last)
    super()
    @first = first
    @last = last
    @created_at ||= Date.today
  end

  def range
    (first .. last)
  end

  #--------------------#
  private

  def created_at
    @created_at ||= Date.today
  end

  # throw uniplemeted method to self range.
  def method_missing(name, *args, &block)
    begin
      self.range.__send__(name, *args, &block)
    rescue => e
      super
    end
  end
end
