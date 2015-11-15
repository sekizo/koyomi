require "koyomi_helper"

describe Date do
  let(:date) { described_class.new(2015, 12, 1) }

  describe "#week_start?" do
    context "week starts with the date" do
      it { expect(date.week_start?(:tue)).to be_truthy }
    end

    context "week not starts with the date" do
      it { expect(date.week_start?(:sun)).to be_falsy }
      it { expect(date.week_start?(:mon)).to be_falsy }
      # it { expect(date.week_start?(:tue)).to be_truthy }
      it { expect(date.week_start?(:wed)).to be_falsy }
      it { expect(date.week_start?(:thu)).to be_falsy }
      it { expect(date.week_start?(:fri)).to be_falsy }
      it { expect(date.week_start?(:sat)).to be_falsy }
    end
  end

  describe "#week_end?" do
    context "week ends with the date" do
      it { expect(date.week_end?(:wed)).to be_truthy }
    end

    context "week not ends with the date" do
      it { expect(date.week_end?(:sun)).to be_falsy }
      it { expect(date.week_end?(:mon)).to be_falsy }
      it { expect(date.week_end?(:tue)).to be_falsy }
      # it { expect(date.week_end?(:wed)).to be_truthy }
      it { expect(date.week_end?(:thu)).to be_falsy }
      it { expect(date.week_end?(:fri)).to be_falsy }
      it { expect(date.week_end?(:sat)).to be_falsy }
    end
  end

  describe "#nth_month_week" do
    subject { date.nth_month_week }
    it { is_expected.to eq 1 }

    context "2015-12-31" do
      let(:date) { Date.new(2015, 12, 31) }
      it { is_expected.to eq 5 }
    end
  end

  describe "#nth_wday" do
    subject { date.nth_wday }
    it { is_expected.to eq [1, :tue] }
  end

  describe "#month_info" do
    subject { date.month_info }

    # nth
    it { expect(subject).to have_key(:nth) }
    its([:nth]) { is_expected.to eq 1 }

    # wday
    it { expect(subject).to have_key(:wday) }
    its([:wday]) { is_expected.to eq :tue }
  end
end
