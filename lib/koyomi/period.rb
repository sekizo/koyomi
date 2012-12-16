# encoding: utf-8

require "date"

class Koyomi::Period
  attr_reader :range
  
  #--------------------#
  # instance methods
  
  def initialize
    super()
    self.created_at = Date.today
  end
  
  #--------------------#
  protected
  
  attr_accessor :created_at
  attr_writer :range
  
  #--------------------#
  private
  
  # throw uniplemeted method to self range.
  def method_missing(name, *args, &block)
    begin
      self.range.__send__(name, *args, &block)
    rescue => e
      super
    end
  end
end