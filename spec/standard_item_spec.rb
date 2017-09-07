require "standard_item"

describe StandardItem do
  subject(:standard_item) { described_class.new("Macguffin", 10, 20) }

  describe "initialization" do
    it "initializes with a name" do
      expect(standard_item.name).to eq "Macguffin"
    end

    it "initializes with a sell_in value" do
      expect(standard_item.sell_in).to eq 10
    end

    it "initializes with a quality value" do
      expect(standard_item.quality).to eq 20
    end
  end

  describe "update_quality" do
    it "decreases the quality by 1 if the sell_in is more than 0" do
      expect{ standard_item.update_quality }.to change{ standard_item.quality }.by(-GildedRose::BASE_QUALITY_CHANGE)
    end

    it "decreases the quality by 2 if the sell_in is negative" do
      old_standard_item = described_class.new("Macguffin", -1, 20)
      expect{ old_standard_item.update_quality }.to change{ old_standard_item.quality }.by(-GildedRose::BASE_QUALITY_CHANGE * 2)
    end
  end

  describe "to_s" do
    it "returns a string with the item's name, sell_in and quality" do
      expect(standard_item.to_s).to eq "Macguffin, 10, 20"
    end
  end
end
