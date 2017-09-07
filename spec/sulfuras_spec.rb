require "sulfuras"

describe Sulfuras do
  subject(:sulfuras) { described_class.new("", 10, 20) }

  describe "initialization" do
    it "initializes with a sell_in value" do
      expect(sulfuras.sell_in).to eq 10
    end

    it "initializes with a quality" do
      expect(sulfuras.quality).to eq 20
    end
  end

  describe "#update_quality" do
    it "does not actually alter the item's quality" do
      expect { sulfuras.update_quality }.not_to change { sulfuras.quality }
    end
  end

  describe "#decrease_sell_in" do
    it "does not actually alter the sell_in value" do
      expect { sulfuras.decrease_sell_in }.not_to change { sulfuras.sell_in }
    end
  end
end
