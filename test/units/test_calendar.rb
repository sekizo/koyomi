# encoding: utf-8

class TestKoyomiCalendar < Test::Unit::TestCase
  context "Koyomi::Calendar" do
    setup do
      @calendar = Koyomi::Calendar.new()
    end # setup
    
    should "have koyomi month" do
      assert(@calendar.koyomi_month.is_a?(Koyomi::Month))
      assert(@calendar.the_month.is_a?(Koyomi::Month))
    end
    
    should "have week start" do
      assert(@calendar.week_start.is_a?(Numeric))
      
      assert_nothing_raised(Exception) do
        (0..6).each do |wd|
          @calendar.week_start = wd
        end
      end
      
      assert_raise(RuntimeError) do
        @calendar.week_start = 7
      end
    end
    
    context "handle correct week" do
      setup do
        @cal = Koyomi::Calendar.new(2012, 12)
      end # setup
      
      should "starts sun." do
        @cal.week_start = :sun
        assert_equal(Date.new(2012, 11, 25), @cal.first, "wrong first.")
        assert_equal(Date.new(2013, 1, 5), @cal.last, "wrong last.")
      end
      
      should "starts mon." do
        @cal.week_start = :mon
        assert_equal(Date.new(2012, 11, 26), @cal.first, "wrong first.")
        assert_equal(Date.new(2013, 1, 6), @cal.last, "wrong last.")
      end
      
      should "starts tue." do
        @cal.week_start = :tue
        assert_equal(Date.new(2012, 11, 27), @cal.first, "wrong first.")
        assert_equal(Date.new(2012, 12, 31), @cal.last, "wrong last.")
      end
      
      should "starts wed." do
        @cal.week_start = :wed
        assert_equal(Date.new(2012, 11, 28), @cal.first, "wrong first.")
        assert_equal(Date.new(2013, 1, 1), @cal.last, "wrong last.")
      end
      
      should "starts thu." do
        @cal.week_start = :thu
        assert_equal(Date.new(2012, 11, 29), @cal.first, "wrong first.")
        assert_equal(Date.new(2013, 1, 2), @cal.last, "wrong last.")
      end
      
      should "starts fri." do
        @cal.week_start = :fri
        assert_equal(Date.new(2012, 11, 30), @cal.first, "wrong first.")
        assert_equal(Date.new(2013, 1, 3), @cal.last, "wrong last.")
      end
      
      should "starts sat." do
        @cal.week_start = :sat
        assert_equal(Date.new(2012, 12, 1), @cal.first, "wrong first.")
        assert_equal(Date.new(2013, 1, 4), @cal.last, "wrong last.")
      end
      
    end # context "handle correct week"
     
  end # context "Koyomi::Calendar"
end