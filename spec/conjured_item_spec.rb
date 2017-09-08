require "conjured_item"

describe ConjuredItem do
  subject(:conjured_item) { described_class.new("Conjured item", 10, 20) }

  describe "initialization" do
    it "initializes with a sell_in value" do
      expect(conjured_item.sell_in).to eq 10
    end

    it "initializes with a quality value" do
      expect(conjured_item.quality).to eq 20
    end
  end

  describe "#update_quality" do
    it "decreases the quality by two if the sell_in is greater than zero" do
      expect { conjured_item.update_quality }
        .to change { conjured_item.quality }.by(-GildedRose::QUALITY_CHANGE * 2)
    end

    it "decreases the quality by four if the sell_in is less than zero" do
      old_conjured_item = described_class.new("item", -1, 20)
      expect { old_conjured_item.update_quality }
        .to change { old_conjured_item.quality }.by(-GildedRose::QUALITY_CHANGE * 4)
    end

    it "cannot decrease the quality below zero" do
      terrible_conjured_item = described_class.new("yuck", 10, 0)
      expect { terrible_conjured_item.update_quality }
        .not_to change { terrible_conjured_item.quality }
    end
  end

  describe "#to_s" do
    it "returns a string with the item name and its sell_in and quality" do
      expect(conjured_item.to_s).to eq "Conjured item, 10, 20"
    end
  end
end
