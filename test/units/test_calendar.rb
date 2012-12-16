# encoding: utf-8

class TestKoyomiCalendar < Test::Unit::TestCase
  context "Koyomi::Calendar" do
    setup do
      @calendar = Koyomi::Calendar.new()
    end # setup
    
    should "have koyomi month" do
      assert(@calendar.koyomi_month.is_a?(Koyomi::Month))
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
    
  end # context "Koyomi::Calendar"
end