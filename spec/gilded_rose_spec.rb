require 'gilded_rose'

describe GildedRose do
  let(:standard_item) { Item.new("Macguffin", 10, 10) }
  let(:aged_brie) { Item.new("Aged Brie", 10, 10) }
  let(:sulfuras) { Item.new("Sulfuras, Hand of Ragnaros", 10, 10) }
  let(:backstage_pass) { Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10) }
  let(:items) { [standard_item, aged_brie, sulfuras, backstage_pass] }
  subject(:gilded_rose) { described_class.new(items) }

  describe "#decrease_item_sell_in" do
    it "decreases the sell_in of standard items by one" do
      gilded_rose.decrease_item_sell_in
      expect(gilded_rose.items[0].sell_in).to eq 9
    end

    it "decreases the sell_in of Aged Brie by one" do
      gilded_rose.decrease_item_sell_in
      expect(gilded_rose.items[1].sell_in).to eq 9
    end

    it "decreases the sell_in of backstage passes by one" do
      gilded_rose.decrease_item_sell_in
      expect(gilded_rose.items[3].sell_in).to eq 14
    end

    it "does not decrease the sell_in of Sulfuras" do
      gilded_rose.decrease_item_sell_in
      expect(gilded_rose.items[2].sell_in).to eq 10
    end
  end

  describe "#standard_item_quality" do
    it "decreases a standard item's quality by one" do
      gilded_rose.standard_item_quality
      expect(gilded_rose.items[0].quality).to eq 9
    end

    it "decreases the quality of a standard item by two if its sell_in is less than 0" do
      standard_item.sell_in = -1
      gilded_rose.standard_item_quality
      expect(gilded_rose.items[0].quality).to eq 8
    end

    it "cannot decrease an item's quality past zero" do
      standard_item.quality = 0
      gilded_rose.standard_item_quality
      expect(gilded_rose.items[0].quality).to eq 0
    end

    it "does nothing to Aged Brie" do
      gilded_rose.standard_item_quality
      expect(gilded_rose.items[1].quality).to eq 10
    end

    it "does nothing to Sulfuras" do
      gilded_rose.standard_item_quality
      expect(gilded_rose.items[2].quality).to eq 10
    end

    it "does nothing to backstage passes" do
      gilded_rose.standard_item_quality
      expect(gilded_rose.items[3].quality).to eq 10
    end
  end

  describe "#aged_brie_quality" do
    it "increases Aged Brie's quality by one" do
      gilded_rose.aged_brie_quality
      expect(gilded_rose.items[1].quality).to eq 11
    end

    it "increases the quality of Aged Brie by two if its sell_in is less than 0" do
      aged_brie.sell_in = -1
      gilded_rose.aged_brie_quality
      expect(gilded_rose.items[1].quality).to eq 12
    end

    it "cannot increases Aged Brie's quality past fifty" do
      aged_brie.quality = 50
      gilded_rose.aged_brie_quality
      expect(gilded_rose.items[1].quality).to eq 50
    end

    it "does nothing to standard items" do
      gilded_rose.aged_brie_quality
      expect(gilded_rose.items[0].quality).to eq 10
    end

    it "does nothing to Sulfuras" do
      gilded_rose.aged_brie_quality
      expect(gilded_rose.items[2].quality).to eq 10
    end

    it "does nothing to backstage passes" do
      gilded_rose.aged_brie_quality
      expect(gilded_rose.items[3].quality).to eq 10
    end
  end

  describe "#update_quality" do
    it "does not change the name" do
      gilded_rose.update_quality
      expect(gilded_rose.items[0].name).to eq "Macguffin"
    end

    it "decreases the quality of standard items by one" do
      gilded_rose.update_quality
      expect(gilded_rose.items[0].quality).to eq 9
    end

    it "decreases the sellin value of standard items by one" do
      gilded_rose.update_quality
      expect(gilded_rose.items[0].sell_in).to eq 9
    end

    it "decreases the quality of standard items by two if sell_in is less than 0" do
      standard_item.sell_in = -1
      gilded_rose.update_quality
      expect(gilded_rose.items[0].quality).to eq 8
    end

    it "cannot decrease an item's quality past zero" do
      standard_item.quality = 0
      gilded_rose.update_quality
      expect(gilded_rose.items[0].quality).to eq 0
    end

    it "increases the quality of Aged Brie by one" do
      gilded_rose.update_quality
      expect(gilded_rose.items[1].quality).to eq 11
    end

    it "increases the quality of Aged Brie by two if sell_in is less than zero" do
      aged_brie.sell_in = -1
      gilded_rose.update_quality
      expect(gilded_rose.items[1].quality).to eq 12
    end

    it "cannot increase Aged Brie's quality past 50" do
      aged_brie.quality = 50
      gilded_rose.update_quality
      expect(gilded_rose.items[1].quality).to eq 50
    end

    it "decreases the sellin value of Aged Brie by one" do
      gilded_rose.update_quality
      expect(gilded_rose.items[1].sell_in).to eq 9
    end

    it "does not change the quality of Sulfuras" do
      gilded_rose.update_quality
      expect(gilded_rose.items[2].quality).to eq 10
    end

    it "does not change the sellin value of Sulfuras" do
      gilded_rose.update_quality
      expect(gilded_rose.items[2].sell_in).to eq 10
    end

    it "decreases the sellin value of backstage passes by one" do
      gilded_rose.update_quality
      expect(gilded_rose.items[3].sell_in).to eq 14
    end

    it "increases the quality of backstage passes by 1 when sell_in is greater than 10" do
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 11
    end

    it "increases the quality of backstage passes by 2 when sell_in is between 5 and 10" do
      backstage_pass.sell_in = 8
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 12
    end

    it "increases the quality of backstage passes by 3 when sell_in is less than 5" do
      backstage_pass.sell_in = 4
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 13
    end

    it "decreases the quality to zero once the sell_in is less than zero" do
      backstage_pass.sell_in = 0
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 0
    end

    it "cannot increase the quality of a backstage pass beyond 50" do
      backstage_pass.quality = 50
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 50
    end
  end
end
