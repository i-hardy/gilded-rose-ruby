require "backstage_pass"

describe BackstagePass do
  subject(:backstage_pass) { described_class.new("Backstage passes to a TAFKAL80ETC concert", 15, 10) }

  describe "initialization" do
    it "initializes with a sell_in value" do
      expect(backstage_pass.sell_in).to eq 15
    end

    it "initializes with a quality value" do
      expect(backstage_pass.quality).to eq 10
    end
  end

  describe "#update_quality" do
    subject(:nearer_backstage_pass) { described_class.new("Pass", 9, 10) }
    subject(:nearest_backstage_pass) { described_class.new("Pass", 4, 10) }
    subject(:expired_backstage_pass) { described_class.new("Pass", -1, 10) }
    subject(:fabulous_backstage_pass) { described_class.new("Pass", 15, 50) }

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

  describe "#to_s" do
    it "returns a string with the item name and its sell_in and quality" do
      expect(backstage_pass.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 15, 10"
    end
  end
end
