require "koyomi_helper"

describe Koyomi do
  describe ".year" do
    subject { described_class.year(*given) }
    context "given 2015" do
      let(:given) { 2015 }
      it { is_expected.to be_kind_of(Koyomi::Year) }
    end
  end

  describe "._ year" do
    context "given 2015" do
      subject { described_class._2015 }
      it { is_expected.to be_kind_of(Koyomi::Year)}
      it { expect(subject.year).to eq 2015 }
    end
  end
end
