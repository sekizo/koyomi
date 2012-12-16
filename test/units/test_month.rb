# encoding: utf-8

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
    
  end # context "Koyomi::Month"
end
