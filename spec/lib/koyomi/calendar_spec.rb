require "spec_helper"
require "koyomi"

describe Koyomi::Calendar do
  let(:calendar) { described_class.new() }

  describe "#koyomi_month" do
    subject { calendar.koyomi_month }

    example("get month") { is_expected.to be_kind_of(Koyomi::Month) }

    example("has alias 'the_month'") do
      expect do
        calendar.the_month
      end.not_to raise_exception
    end
  end

  describe "#month" do
    subject { calendar.month }

    it { is_expected.to be_kind_of(Integer) }
  end

  describe "#week_start" do
    subject { calendar.week_start }

    it { is_expected.to be_kind_of(Numeric) }
  end

  describe "#week_start=" do
    Koyomi::Week::WDAYS.each do |wday|
      context "week starts with #{wday}" do
        before { calendar.week_start = wday }
        describe "#first" do
          it { expect(calendar.first.wday).to eq Koyomi::Week::WDAYS.index(wday) }
        end

        describe "#last" do
          it { expect(calendar.last.wday).to eq ((Koyomi::Week::WDAYS.index(wday) + 6) % 7)}
        end
      end
    end
  end

  describe "#weeks" do
    subject { calendar.weeks }

    describe "size" do
      subject { calendar.weeks.size }
      let(:calendar) { described_class.new(*test_case) }
      let(:test_case) { nil }

      context "has 5 weeks" do
        # 2015-11 ~ 2015-12 start with sunday
        #
        #  1  2  3  4  5  6  7
        #  8  9 10 11 12 13 14
        # 15 16 17 18 19 20 21
        # 22 23 24 25 26 27 28
        # 29 30  1  2  3  4  5
        #
        # #=> 5 weeks
        let(:test_case) { [2015, 11, :sun] }
        it { is_expected.to eq 5 }
      end # context "has 5 weeks"

      context "has 6 weeks" do
        # 2015-10 ~ 2015-12 start with monday
        #
        # 26 27 28 29 30 31  1
        #  2  3  4  5  6  7  8
        #  9 10 11 12 13 14 15
        # 16 17 18 19 20 21 22
        # 23 24 25 26 27 28 29
        # 30  1  2  3  4  5  6
        #
        # #=> 6 weeks
        let(:test_case) { [2015, 11, :mon] }
        it { is_expected.to eq 6 }
      end # context "has 6 weeks"
    end # describe size
  end

  describe "#nth_wday" do
    let(:calendar) { described_class.new(2015, 11, :sun) }
    # 2015-11 ~ 2015-12 start with sunday
    #
    #  1  2  3  4  5  6  7
    #  8  9 10 11 12 13 14
    # 15 16 17 18 19 20 21
    # 22 23 24 25 26 27 28
    # 29 30  1  2  3  4  5

    context "first saturday" do
      subject { calendar.nth_wday(1, :sat) }
      it { is_expected.to eq Date.new(2015, 11, 7) }
    end

    context "5th tuesday" do
      subject { calendar.nth_wday(5, :tue) }
      it { is_expected.to eq Date.new(2015, 12, 1) }
    end

    context "6th sunday" do
      subject { calendar.nth_wday(6, :mon) }
      xit { expect { subject }.to raise_error(RuntimeError) }
    end
  end
end
