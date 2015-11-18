require "koyomi_helper"

describe Koyomi::Month do
  let(:month) { described_class.new(today.month, today.year) }
  let!(:today) { Date.today }

  describe "#range" do
    subject { month.range }
    it { is_expected.to be_kind_of(Range) }
  end

  describe "#month" do
    subject { month.month }
    it { is_expected.to eq today.month }
  end

  describe "#next" do
    subject { month.next }
    it { is_expected.to be_kind_of(described_class) }
    it { expect(subject.month).to eq ((month.first + 32).month) }
  end

  describe "#prev" do
    subject { month.prev }
    it { is_expected.to be_kind_of(described_class) }
    it { expect(subject.month).to eq ((month.first - 1).month) }
  end

  describe "#nth_wday!" do
    subject { month.nth_wday!(*given) }
    let(:month) { described_class.new(12, 2015) }
    # 2015-12
    #     1  2  3  4  5  6
    #  7  8  9 10 11 12 13
    # 14 15 16 17 18 19 20
    # 21 22 23 24 25 26 27
    # 28 29 30 31

    context "5th friday" do
      let(:given) { [5, :fri] }
      it { expect { subject }.to raise_error(Koyomi::WrongRangeError) }
    end
  end

  describe "#nth_wday" do
    subject { month.nth_wday(*given) }
    let(:month) { described_class.new(12, 2015) }
    # 2015-12
    #     1  2  3  4  5  6
    #  7  8  9 10 11 12 13
    # 14 15 16 17 18 19 20
    # 21 22 23 24 25 26 27
    # 28 29 30 31

    context "1st saturday" do
      let(:given) { [1, :sat] }
      it { is_expected.to eq Date.new(2015, 12, 5) }
    end

    context "first friday" do
      let(:given) { [:first, :fri] }
      it { is_expected.to eq Date.new(2015, 12, 4) }
    end

    context "last saturday" do
      let(:given) { [:last, :sat] }
      it { is_expected.to eq Date.new(2015, 12, 26) }
    end

    context "5th friday" do
      let(:given) { [5, :fri] }
      it { expect { subject }.not_to raise_error }
      it { is_expected.to eq Date.new(2016, 1, 1) }
    end
  end

  describe "#wdays" do
    subject { month.wdays(given) }
    let(:month) { described_class.new(12, 2015) }
    # 2015-12
    #     1  2  3  4  5  6
    #  7  8  9 10 11 12 13
    # 14 15 16 17 18 19 20
    # 21 22 23 24 25 26 27
    # 28 29 30 31

    context "monday" do
      let(:given) { :mon }
      it { expect(subject.size).to eq 4 }
    end

    context "tuesday" do
      let(:given) { :tue }
      it { expect(subject.size).to eq 5 }
    end
  end

  describe "#cycles" do
    subject { month.cycles(*given) }
    let(:month) { described_class.new(12, 2015) }
    # 2015-12
    #     1  2  3  4  5  6
    #  7  8  9 10 11 12 13
    # 14 15 16 17 18 19 20
    # 21 22 23 24 25 26 27
    # 28 29 30 31

    context "first and third monday, friday" do
      # 4, 7, 18, 21
      let(:given) { [[1, 3], [:mon, :fri]] }
      its(:size)  { is_expected.to eq 4 }
      its(:first) { is_expected.to eq Date.new(2015, 12, 4) }
      its(:last)  { is_expected.to eq Date.new(2015, 12, 21) }
    end

    context "every monday, thursday" do
      # 3, 7, 10, 14, 17, 21, 24, 28, 31
      let(:given) { [:every, [:mon, :thu]] }
      its(:size)  { is_expected.to eq 9 }
      its(:first) { is_expected.to eq Date.new(2015, 12, 3) }
      its(:last)  { is_expected.to eq Date.new(2015, 12, 31) }
    end
  end
end
