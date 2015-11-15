require "koyomi_helper"

describe Koyomi::Week do
  let(:week) { described_class.new(date, week_start) }
  let!(:today) { Date.today }

  describe ".windex" do
    it { expect(described_class.windex(:sun)). to eq 0 }
    it { expect(described_class.windex(:mon)). to eq 1 }
    it { expect(described_class.windex(:tue)). to eq 2 }
    it { expect(described_class.windex(:wed)). to eq 3 }
    it { expect(described_class.windex(:thu)). to eq 4 }
    it { expect(described_class.windex(:fri)). to eq 5 }
    it { expect(described_class.windex(:sat)). to eq 6 }
  end

  context "include 2015-12-01" do
    let(:date) { Date.new(2015, 12, 1) }

    context "start with monday(2015-11-30 ~ 2015-12-06)" do
      let(:week_start) { :mon }

      describe "#range" do
        subject { week.range }
        its(:count) { is_expected.to eq 7 }
        its(:first) { is_expected.to eq Date.new(2015, 11, 30) }
        its(:last)  { is_expected.to eq Date.new(2015, 12, 6) }
      end

      describe "wday name method" do
        it { expect(week.sun).to eq Date.new(2015, 12, 6) }
        it { expect(week.mon).to eq Date.new(2015, 11, 30) }
        it { expect(week.tue).to eq Date.new(2015, 12, 1) }
        it { expect(week.wed).to eq Date.new(2015, 12, 2) }
        it { expect(week.thu).to eq Date.new(2015, 12, 3) }
        it { expect(week.fri).to eq Date.new(2015, 12, 4) }
        it { expect(week.sat).to eq Date.new(2015, 12, 5) }
      end
    end # context "start with monday(2015-11-30 ~ 2015-12-06)"

    context "start with sunday(2015-11-29 ~ 2015-12-05)" do
      let(:week_start) { :sun }

      describe "#range" do
        subject { week.range }
        its(:count) { is_expected.to eq 7 }
        its(:first) { is_expected.to eq Date.new(2015, 11, 29) }
        its(:last)  { is_expected.to eq Date.new(2015, 12, 5) }
      end
    end # context "start with monday(2015-11-29 ~ 2015-12-05)"

  end # context "include 2015-12-01"
end
