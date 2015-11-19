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
end
