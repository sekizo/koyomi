require "koyomi_helper"

describe Koyomi::MonthCycle do
  let(:month_cycle) { described_class.new(*initialized) }

  describe ".new" do
    it("initialized with Koyomi::Month") do
      month = Koyomi::Month.new
      expect { described_class.new(month) }.not_to raise_error
    end
  end

  describe "#dates" do
    subject { month_cycle.dates }
    let(:initialized) { Koyomi::Month.new }
    it { is_expected.to be_kind_of(Array) }
  end

  context "2015-11" do
    let(:initialized) { Koyomi::Month.new(11, 2015) }
    let(:action) { month_cycle.add(given) }

    context "[[3, 1], :fri] given" do
      let(:given) { [[3, 1], :fri] }
      let(:expected) { [Date.new(2015, 11, 6), Date.new(2015, 11, 20)] }

      describe "#add" do
        subject { action }
        it { expect { subject }.not_to raise_error }
        it { expect { subject }.to change { month_cycle.dates.size }.from(0).to(expected.size) }
      end

      describe "#dates" do
        subject { month_cycle.dates }
        before { action }
        it { is_expected.to eq expected }
        it("sort") { expect(subject.first).to be < subject.last }
        it("uniq") { expect(subject.size).to eq expected.size }
      end
    end

    context "Date given" do
      let(:given) { date }
      let(:date) { Date.new(2015, 11, 1) }
      let(:expected) { [date] }

      describe "#add" do
        subject { action }
        it { expect { subject }.not_to raise_error }
        it { expect { subject }.to change { month_cycle.dates.size }.from(0).to(expected.size) }
      end

      describe "#dates" do
        subject { month_cycle.dates }
        before { action }
        it { is_expected.to eq expected }
      end
    end

    context "invalid date given" do
      let(:given) { date }
      let(:date) { Date.new(2015, 12, 1) }
      it { expect { month_cycle.add(date) }.to raise_error(Koyomi::WrongRangeError) }
      let(:expected) { Koyomi::WrongRangeError }

      describe "#add" do
        subject { action }
        it { expect { subject }.to raise_error(expected) }
      end
    end

    context "add some times" do
      let(:action) do
        month_cycle.add(Date.new(2015, 11, 6)) # first friday
        month_cycle.add([[1, 3], :fri]) # 2015-11-06, 2015-11-20
        month_cycle.add(Date.new(2015, 11, 1))
      end
      let(:expected) { [Date.new(2015, 11,1), Date.new(2015, 11,6), Date.new(2015, 11,20)] }

      describe "#add" do
        subject { action }
        it { expect { subject }.not_to raise_error }
        it { expect { subject }.to change { month_cycle.dates.size }.from(0).to(expected.size) }
      end

      describe "#dates" do
        subject { month_cycle.dates }
        before { action }
        it { is_expected.to eq expected }
        it("is sorted") { expect(subject.first).to be < subject.last }
        it("is uniqed") { expect(subject.size).to eq expected.size }
      end
    end

    context "add sequencial" do
      let(:action) do
        month_cycle.add([[3, 1], :fri]).add(Date.new(2015, 11, 1))
      end
      let(:expected) { [Date.new(2015, 11,1), Date.new(2015, 11,6), Date.new(2015, 11,20)] }

      describe "#add" do
        subject { action }
        it { expect { subject }.not_to raise_error }
        it { expect { subject }.to change { month_cycle.dates.size }.from(0).to(expected.size) }
      end

      describe "#dates" do
        subject { month_cycle.dates }
        before { action }
        it { is_expected.to eq expected }
        it("is sorted") { expect(subject.first).to be < subject.last }
        it("is uniqed") { expect(subject.size).to eq expected.size }
      end
    end
  end
end
