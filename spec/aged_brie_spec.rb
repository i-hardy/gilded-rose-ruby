require "aged_brie"

describe AgedBrie do
  subject(:aged_brie) { described_class.new("Aged Brie", 10, 20) }

  describe "initialization" do
    it "initializes with a sell_in value" do
      expect(aged_brie.sell_in).to eq 10
    end

    it "initializes with a quality value" do
      expect(aged_brie.quality).to eq 20
    end
  end

  describe "#update_quality" do
    it "increases the quality by 1 if the sell_in is greater than 0" do
      expect{ aged_brie.update_quality }.to change{ aged_brie.quality }.by GildedRose::BASE_SELL_IN_CHANGE
    end

    it "increases the quality by 2 if the sell_in is less than 0" do
      super_aged_brie = described_class.new("Aged Brie", -1, 20)
      expect{ super_aged_brie.update_quality }.to change{ super_aged_brie.quality }.by GildedRose::BASE_SELL_IN_CHANGE * 2
    end

    it "cannot increase the quality beyond 50" do
      high_quality_brie = described_class.new("Aged Brie", 10, 50)
      expect{ high_quality_brie.update_quality }.not_to change{ high_quality_brie.quality }
    end
  end

  describe "#to_s" do
    it "returns a string with the item name and its sell_in and quality" do
      expect(aged_brie.to_s).to eq "Aged Brie, 10, 20"
    end
  end
end
