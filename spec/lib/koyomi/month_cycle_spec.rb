require "koyomi_helper"

describe Koyomi::MonthCycle do
  let(:month_cycle) { described_class.new(*given) }

  describe "#new" do
    it("initialized with Koyomi::Month") do
      month = Koyomi::Month.new
      expect { described_class.new(month) }.not_to raise_error
    end
  end

  describe "#dates" do
    subject { month_cycle.dates }
    let(:given) { Koyomi::Month.new }
    it { is_expected.to be_kind_of(Array) }
  end

  context "2015-11" do
    let(:given) { Koyomi::Month.new(11, 2015) }
    describe "#add" do
      subject { month_cycle.dates }

      context "[[1, 3], :fri]" do
        before { month_cycle.add([[1, 3], :fri]) }
        let(:cycle) { [[1, 3], :fri] }
        let(:expected) { [Date.new(2015, 11, 6), Date.new(2015, 11, 20)] }
        it { is_expected.to eq expected }
      end

      context "Date given" do
        before { month_cycle.add(date) }
        let(:date) { Date.new(2015, 11, 1) }
        it { is_expected.to include(date) }
      end

      context "invalid date given" do
        let(:date) { Date.new(2015, 12, 1) }
        it { expect { month_cycle.add(date) }.to raise_error(Koyomi::WrongRangeError) }
      end

      context "add some times" do
        before do
          month_cycle.add(Date.new(2015, 11, 6)) # first friday
          month_cycle.add([[1, 3], :fri]) # 2015-11-06, 2015-11-20
          month_cycle.add(Date.new(2015, 11, 1))
        end

        describe "uniqed" do
          its("size") { is_expected.to eq 3 }
        end

        describe "sorted" do
          its("first") { is_expected.to eq Date.new(2015, 11, 1)}
        end
      end

      context "add sequencial" do
        subject { month_cycle.add(Date.new(2015, 11, 1)).add([[1, 3], :fri]) }
        it { expect { subject }.not_to raise_error }
        it { expect(subject.dates.size).to eq 3 }
      end
    end
  end
end
