require "koyomi_helper"

describe Koyomi::Period do
  let(:period) { described_class.new(*initialize_with) }

  describe ".new" do
    subject { period }

    context "no arguments given" do
      let(:initialize_with) { nil }
      it { expect { subject }.not_to raise_error }

      describe "#range" do
        subject{ period.range }
        its("count") { is_expected.to eq 1 }
        its("first") { is_expected.to be_kind_of Date}
      end
    end

    context "first and last given" do
      let(:initialize_with) { [Date.new(2015, 12, 1), Date.new(2015, 12, 31)] }
      it { expect { subject }.not_to raise_error }
    end
  end

  context "initialized normaly" do
    let(:initialize_with) { [first, last] }
    let(:first) { Date.new(2015, 12, 1) }
    let(:last)  { Date.new(2015, 12, 31) }

    describe "#range" do
      subject { period.range }
      its("first")  { is_expected.to eq first }
      its("last")   { is_expected.to eq last }
    end
  end
end
