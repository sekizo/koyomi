require "koyomi_helper"

describe Koyomi::Year do
  let(:year) { described_class.new(*given) }

  describe ".of" do
    let(:year) { described_class.of(*given) }
    let!(:today) { Date.today }

    context "nothing given" do
      subject { year }
      let(:given) { }
      it { expect(subject.year).to eq today.year }
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
