# encoding: utf-8

require "test_helper"

class TestKoyomiMonth < Test::Unit::TestCase
  context "Koyomi::Month" do
    
    setup do
      @month = Koyomi::Month.new()
    end
    
    should "have range" do
      assert(@month.range.is_a?(Range))
    end

    should "respond to next" do
      assert(@month.next.is_a?(Koyomi::Month))
    end
    
    should "respond to prev" do
      assert(@month.prev.is_a?(Koyomi::Month))
    end
    
    should "respond to nth_wday" do
      month = Koyomi::Month.new(12, 2012)
      assert_equal(Date.new(2012, 12, 1), month.nth_wday(1, :sat))
    end
    
    should "respond to cycles" do
      month = Koyomi::Month.new(12, 2012)
      
      assert_equal(4, month.cycles([1,3], [:tue, :fri]).size)
      
      dates = month.cycles(:every, [:mon, :thu])
      assert_equal(9, dates.size)
      
      dates = month.cycles(:every, [:mon, :sun])
      assert_equal(10, dates.size)
    end
    
  end # context "Koyomi::Month"
end
