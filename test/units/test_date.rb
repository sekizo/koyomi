# encoding: utf-8

require "test_helper"

class TestKoyomiDate < Test::Unit::TestCase
  context "Koyomi::Date" do
    setup do
      @date = Date.new(2012, 12, 16)
      @wdays = Koyomi::Calendar::WEEK_START_STRING
    end # setup
    
    should "correct week end" do
      cal = Koyomi::Calendar.of(@date)
      
      cal.each do |date|
        @wdays.each do |wd|
          if (date + 1).wday == @wdays.index(wd)
            assert(date.week_end?(wd))
          else
            assert(!date.week_end?(wd))
          end
        end # each wd
      end # each date
    end # should "correct week end"
    
  end # context "Koyomi::Date"
end
