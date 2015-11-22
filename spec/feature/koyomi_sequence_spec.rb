require "koyomi_helper"

describe Koyomi do
  describe "sequence" do
    subject { described_class._2015._12._25 }
    it { is_expected.to eq Date.new(2015, 12, 25) }
  end
end
