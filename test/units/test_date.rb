# encoding: utf-8

require "test_helper"

class TestKoyomiDate < Test::Unit::TestCase
  context "Koyomi::Date" do
    setup do
      @date = Date.new(2012, 12, 16)
      @wdays = Date::WEEK_WDAYS
    end # setup
    
    should "correct week start, end" do
      cal = Koyomi::Calendar.of(@date)
      
      cal.each do |date|
        @wdays.each do |wd|
          if (date + 1).wday == @wdays.index(wd)
            assert(date.week_end?(wd))
          else
            assert(!date.week_end?(wd))
          end
          
          if (date).wday == @wdays.index(wd)
            assert(date.week_start?(wd))
          else
            assert(!date.week_start?(wd))
          end
        end # each wd
      end # each date
    end # should "correct week end"
    
    should "respond to nth_wday" do
      assert_equal(3, @date.nth_month_week)
    end # should "respond to nth_wday"
    
    should "respond to info" do
      assert_equal(3, @date.month_info[:nth])
      assert_equal(:sun, @date.month_info[:wday])
    end
    
  end # context "Koyomi::Date"
end
