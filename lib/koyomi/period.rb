# encoding: utf-8

class Koyomi::Period
  attr_reader :range
  
  #--------------------#
  protected
  
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