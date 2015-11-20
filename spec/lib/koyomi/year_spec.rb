require "koyomi_helper"

describe Koyomi::Year do
  let(:year) { described_class.new(*given) }

  describe ".of" do
    subject { year }
    let(:year) { described_class.of(*given) }
    let!(:today) { Date.today }

    context "given nothing" do
      let(:given) { }
      it { expect(subject.year).to eq today.year }
    end

    context "given today" do
      let(:given) { today }
      it { expect(subject.year).to eq today.year }
    end

    context "given next year's first" do
      let(:given) { Date.new(today.year + 1, 1, 1) }
      it { expect(subject.year).to eq (today.year + 1)}
    end

    context "given prev year's first" do
      let(:given) { Date.new(today.year - 1, 1, 1) }
      it { expect(subject.year).to eq (today.year - 1)}
    end
  end

  describe "#first" do
    subject { year.first }

    context "given year 2015" do
      let(:given) { 2015 }
      it { is_expected.to eq Date.new(2015, 1, 1) }
    end
  end

  describe "#last" do
    subject { year.last }

    context "given year 2015" do
      let(:given) { 2015 }
      it { is_expected.to eq Date.new(2015, 12, 31) }
    end
  end

  describe "month mothods" do
    (1..12).each do |month|
      context "given month #{month}" do
        let(:given) { month }
        subject { year.__send__("_#{month}") }
        it { is_expected.to be_kind_of(Koyomi::Month) }
        describe "its month" do
          it { expect(subject.month).to eq month }
        end
      end
    end
  end

  describe "#month" do
    subject { year.month(given) }
    (1..12).each do |month|
      context "given #{month}" do
        let(:given) { month }
        it { is_expected.to be_kind_of(Koyomi::Month) }
        describe "its month" do
          it { expect(subject.month).to eq month }
        end
      end
    end
  end

  [:uruu?, :leap?].each do |method|
    describe "##{method}" do
      subject { year.__send__(method) }
      let(:year) { described_class.new(given) }

      context "given year 1999" do
        let(:given) { 1999 }
        it { is_expected.to be_falsy }
      end

      context "given year 2000" do
        let(:given) { 2000 }
        it { is_expected.to be_truthy }
      end

      context "given year 2004" do
        let(:given) { 2004 }
        it { is_expected.to be_truthy }
      end

      context "given year 2100" do
        let(:given) { 2100 }
        it { is_expected.to be_falsy }
      end
    end
  end
end
