# encoding: utf-8

require "test_helper"

class TestKoyomiWeek < Test::Unit::TestCase
  context "Koyomi::Week" do
    
    setup do
      @today = Date.today
      @year = @today.year
      @month = @today.month
    end # setup  
    
    should "generate week instance" do
      assert_nothing_raised(Exception) do
        @week = Koyomi::Week.new(@today, Koyomi::DEFAULT_WEEK_START)
      end
    end # should "generate week instance"
    
    should "calcurate windex" do
      date = Date.new(2012, 12, 23)
      assert(Koyomi::Week.windex(:sun) == (date).wday)
      assert(Koyomi::Week.windex(:mon) == (date + 1).wday)
      assert(Koyomi::Week.windex(:tue) == (date + 2).wday)
      assert(Koyomi::Week.windex(:wed) == (date + 3).wday)
      assert(Koyomi::Week.windex(:thu) == (date + 4).wday)
      assert(Koyomi::Week.windex(:fri) == (date + 5).wday)
      assert(Koyomi::Week.windex(:sat) == (date + 6).wday)
    end
    
    should "start specified week day" do
      date = Date.new(2012, 12, 23)
      Koyomi::Week::WDAYS.each do |wday|
        assert_equal(Koyomi::Week.windex(wday), Koyomi::Week.new(date, wday).range.first.wday)
      end
    end
    
    should "respond date to request of week day" do
      date = Date.new(2012, 12, 23)
      Koyomi::Week::WDAYS.each do |wday|
        assert_equal(Koyomi::Week.windex(wday), Koyomi::Week.new(date, wday).__send__(wday).wday)
      end
    end
    
  end # context "Koyomi::Week"
end
