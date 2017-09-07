require "item_classes"

describe AgedBrie do
  subject(:aged_brie) { described_class.new(10, 20) }

  describe "initialization" do
    it "initializes with a sell_in value" do
      expect(aged_brie.sell_in).to eq 10
    end

    it "initializes with a quality value" do
      expect(aged_brie.quality).to eq 20
    end
  end

  describe "#decrease_sell_in" do
    it "decreases the sell_in value" do
      expect{ aged_brie.decrease_sell_in }.to change{ aged_brie.sell_in }.by -GildedRose::BASE_SELL_IN_CHANGE
    end
  end

  describe "#update_quality" do
    it "increases the quality by 1 if the sell_in is greater than 0" do
      expect{ aged_brie.update_quality }.to change{ aged_brie.quality }.by GildedRose::BASE_SELL_IN_CHANGE
    end

    it "increases the quality by 2 if the sell_in is less than 0" do
      super_aged_brie = described_class.new(-1, 20)
      expect{ super_aged_brie.update_quality }.to change{ super_aged_brie.quality }.by GildedRose::BASE_SELL_IN_CHANGE * 2
    end

    it "cannot increase the quality beyond 50" do
      high_quality_brie = described_class.new(10, 50)
      expect{ high_quality_brie.update_quality }.not_to change{ high_quality_brie.quality }
    end
  end
end

describe BackstagePass do
  subject(:backstage_pass) { described_class.new(15, 10) }

  describe "initialization" do
    it "initializes with a sell_in value" do
      expect(backstage_pass.sell_in).to eq 15
    end

    it "initializes with a quality value" do
      expect(backstage_pass.quality).to eq 10
    end
  end

  describe "#decrease_sell_in" do
    it "decreases the sell_in value" do
      expect{ backstage_pass.decrease_sell_in }.to change{ backstage_pass.sell_in }.by -GildedRose::BASE_SELL_IN_CHANGE
    end
  end

  describe "#update_quality" do
    subject(:nearer_backstage_pass) { described_class.new(9, 10) }
    subject(:nearest_backstage_pass) { described_class.new(4, 10) }
    subject(:expired_backstage_pass) { described_class.new(-1, 10) }
    subject(:fabulous_backstage_pass) { described_class.new(15, 50) }

    it "increases the quality by 1 when sell_in is greater than 10" do
      expect{ backstage_pass.update_quality }.to change{ backstage_pass.quality }.by GildedRose::BASE_SELL_IN_CHANGE
    end

    it "increases the quality by 2 when sell_in is between 5 and 10" do
      expect{ nearer_backstage_pass.update_quality }.to change{ nearer_backstage_pass.quality }.by GildedRose::BASE_SELL_IN_CHANGE * 2
    end

    it "increases the quality by 3 when sell_in is less than 5" do
      expect{ nearest_backstage_pass.update_quality }.to change{ nearest_backstage_pass.quality }.by GildedRose::BASE_SELL_IN_CHANGE * 3
    end

    it "decreases the quality to zero once the sell_in is less than zero" do
      expired_backstage_pass.update_quality
      expect(expired_backstage_pass.quality).to eq 0
    end

    it "cannot increase the quality beyond 50" do
      expect{ fabulous_backstage_pass.update_quality }.not_to change{ fabulous_backstage_pass.quality }
    end
  end
end
