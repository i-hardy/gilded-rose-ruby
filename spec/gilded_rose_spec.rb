require 'gilded_rose'

describe GildedRose do
  let(:standard_item) { Item.new("Macguffin", 10, 10) }
  let(:aged_brie) { Item.new("Aged Brie", 10, 10) }
  let(:sulfuras) { Item.new("Sulfuras, Hand of Ragnaros", 10, 10) }
  let(:backstage_pass) { Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10) }
  let(:aged_brie_class) { class_double('AgedBrie') }
  let(:backstage_pass_class) { class_double('BackstagePass') }
  let(:items) { [standard_item, aged_brie, sulfuras, backstage_pass] }
  let(:brie_instance) { double(:aged_brie) }
  let(:pass_instance) { double(:backstage_pass) }

  subject(:gilded_rose) { described_class.new(items,
                                              brie_class: aged_brie_class,
                                              pass_class: backstage_pass_class) }

  before do
    allow(aged_brie_class).to receive(:new) { brie_instance}
    allow(backstage_pass_class).to receive(:new) { pass_instance }
    allow(brie_instance).to receive_messages(update_quality: nil, decrease_sell_in: nil)
    allow(pass_instance).to receive_messages(update_quality: nil, decrease_sell_in: nil)
  end

  describe "#create_special_items" do
    it "populates the special items list with those items that have their own class" do
      gilded_rose.create_special_items
      expect(gilded_rose.special_items.size).to eq 2
    end

    it "populates the list with instances of the Aged Brie class when said items are present" do
      expect(aged_brie_class).to receive(:new).with(instance_of(String), 10, 10)
      gilded_rose.create_special_items
    end

    it "populates the list with instances of the Backstage Pass class when said items are present" do
      expect(backstage_pass_class).to receive(:new).with(instance_of(String), 15, 10)
      gilded_rose.create_special_items
    end

    it "deletes aged brie items from the main items list" do
      gilded_rose.create_special_items
      expect(gilded_rose.items).not_to include aged_brie
    end

    it "deletes backstage pass items from the main items list" do
      gilded_rose.create_special_items
      expect(gilded_rose.items).not_to include backstage_pass
    end
  end

  describe "#special_items_update" do
    before do
      gilded_rose.create_special_items
    end

    it "updates the quality of aged brie" do
      expect(brie_instance).to receive(:update_quality)
      gilded_rose.special_items_update
    end

    it "updates the sell_in of aged brie" do
      expect(brie_instance).to receive(:decrease_sell_in)
      gilded_rose.special_items_update
    end

    it "updates the quality of backstage passes" do
      expect(pass_instance).to receive(:update_quality)
      gilded_rose.special_items_update
    end

    it "updates the sell_in of backstage passes" do
      expect(pass_instance).to receive(:decrease_sell_in)
      gilded_rose.special_items_update
    end
  end

  describe "#decrease_item_sell_in" do
    it "decreases the sell_in of standard items by one" do
      gilded_rose.decrease_item_sell_in
      expect(gilded_rose.items[0].sell_in).to eq 9
    end

    it "does not decrease the sell_in of Sulfuras" do
      gilded_rose.decrease_item_sell_in
      expect(gilded_rose.items[1].sell_in).to eq 10
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

    it "does nothing to Sulfuras" do
      gilded_rose.standard_item_quality
      expect(gilded_rose.items[1].quality).to eq 10
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

    it "does not change the quality of Sulfuras" do
      gilded_rose.update_quality
      expect(gilded_rose.items[1].quality).to eq 10
    end

    it "does not change the sellin value of Sulfuras" do
      gilded_rose.update_quality
      expect(gilded_rose.items[1].sell_in).to eq 10
    end
  end
end
