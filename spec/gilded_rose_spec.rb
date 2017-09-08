require "gilded_rose"

describe GildedRose do
  let(:standard_item_class) { class_double("StandardItem") }
  let(:aged_brie_class) { class_double("AgedBrie") }
  let(:sulfuras_class) { class_double("Sulfuras") }
  let(:backstage_pass_class) { class_double("BackstagePass") }
  let(:standard_instance) { double(:standard_item) }
  let(:brie_instance) { double(:aged_brie) }
  let(:pass_instance) { double(:backstage_pass) }
  let(:sulfuras_instance) { double(:sulfuras) }

  let(:items) do
    [Item.new("Macguffin", 10, 10),
     Item.new("Aged Brie", 10, 10),
     Item.new("Sulfuras, Hand of Ragnaros", 10, 10),
     Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)]
  end

  subject(:gilded_rose) do
    described_class.new(items,
                        standard_class: standard_item_class,
                        brie_class: aged_brie_class,
                        sulfuras_class: sulfuras_class,
                        pass_class: backstage_pass_class)
  end

  before do
    allow(standard_item_class).to receive(:new) { standard_instance }
    allow(aged_brie_class).to receive(:new) { brie_instance }
    allow(sulfuras_class).to receive(:new) { sulfuras_instance }
    allow(backstage_pass_class).to receive(:new) { pass_instance }
    allow(standard_instance).to receive_messages(update_quality: nil,
                                                 decrease_sell_in: nil)
    allow(brie_instance).to receive_messages(update_quality: nil,
                                             decrease_sell_in: nil)
    allow(sulfuras_instance).to receive_messages(update_quality: nil,
                                                 decrease_sell_in: nil)
    allow(pass_instance).to receive_messages(update_quality: nil,
                                             decrease_sell_in: nil)
  end

  describe "#create_classified_items" do
    it "creates instances of the Aged Brie class" do
      expect(aged_brie_class).to receive(:new)
        .with(instance_of(String), 10, 10)
      gilded_rose.create_classified_items
    end

    it "creates instances of the Sulfuras class" do
      expect(sulfuras_class).to receive(:new)
        .with(instance_of(String), 10, 10)
      gilded_rose.create_classified_items
    end

    it "creates instances of the Backstage Pass class" do
      expect(backstage_pass_class).to receive(:new)
        .with(instance_of(String), 15, 10)
      gilded_rose.create_classified_items
    end
  end

  describe "#classified_items_update" do
    it "updates the quality of aged brie" do
      expect(brie_instance).to receive(:update_quality)
      gilded_rose.classified_items_update
    end

    it "updates the sell_in of aged brie" do
      expect(brie_instance).to receive(:decrease_sell_in)
      gilded_rose.classified_items_update
    end

    it "updates the quality of backstage passes" do
      expect(pass_instance).to receive(:update_quality)
      gilded_rose.classified_items_update
    end

    it "updates the sell_in of backstage passes" do
      expect(pass_instance).to receive(:decrease_sell_in)
      gilded_rose.classified_items_update
    end
  end

  describe "#update_items_list" do
    before do
      allow(standard_instance).to receive_messages(sell_in: 9, quality: 20)
      allow(brie_instance).to receive_messages(sell_in: 15, quality: 30)
      allow(sulfuras_instance).to receive_messages(sell_in: 5, quality: 50)
      allow(pass_instance).to receive_messages(sell_in: 8, quality: 25)
    end

    it "updates a standard item's quality based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[0].quality).to eq 20
    end

    it "updates a standard item's sell_in based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[0].sell_in).to eq 9
    end

    it "updates aged brie's quality based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[1].quality).to eq 30
    end

    it "updates aged brie's sell_in based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[1].sell_in).to eq 15
    end

    it "updates sulfuras's quality based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[2].quality).to eq 50
    end

    it "updates sulfuras's sell_in based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[2].sell_in).to eq 5
    end

    it "updates a backstage pass's quality based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[3].quality).to eq 25
    end

    it "updates a backstage pass's sell_in based on its counterpart" do
      gilded_rose.update_items_list
      expect(gilded_rose.items[3].sell_in).to eq 8
    end
  end

  describe "#get_item_class" do
    it "retrieves the item class based on the hash keys" do
      expect(gilded_rose.get_item_class("Aged Brie")).to eq aged_brie_class
    end

    it "otherwise returns the standard item class" do
      expect(gilded_rose.get_item_class("Moomin Toy")).to eq standard_item_class
    end
  end

  describe "#update_quality" do
    before do
      allow(standard_instance).to receive_messages(sell_in: 9, quality: 9)
      allow(brie_instance).to receive_messages(sell_in: 9, quality: 11)
      allow(sulfuras_instance).to receive_messages(sell_in: 10, quality: 10)
      allow(pass_instance).to receive_messages(sell_in: 14, quality: 11)
    end

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

    it "decreases the quality of standard items by two if sell_in < 0" do
      allow(standard_instance).to receive_messages(sell_in: 0, quality: 8)
      gilded_rose.update_quality
      expect(gilded_rose.items[0].quality).to eq 8
    end

    it "cannot decrease an item's quality past zero" do
      allow(standard_instance).to receive_messages(sell_in: 0, quality: 0)
      gilded_rose.update_quality
      expect(gilded_rose.items[0].quality).to eq 0
    end

    it "increases the quality of Aged Brie by one" do
      gilded_rose.update_quality
      expect(gilded_rose.items[1].quality).to eq 11
    end

    it "increases the quality of Aged Brie by two if sell_in < zero" do
      allow(brie_instance).to receive_messages(sell_in: -1, quality: 12)
      gilded_rose.update_quality
      expect(gilded_rose.items[1].quality).to eq 12
    end

    it "cannot increase Aged Brie's quality past 50" do
      allow(brie_instance).to receive_messages(sell_in: 9, quality: 50)
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

    it "increases backstage pass quality by 1 when sell_in > 10" do
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 11
    end

    it "increases backstage pass quality by 2 when 5 < sell_in < 10" do
      allow(pass_instance).to receive_messages(sell_in: 6, quality: 12)
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 12
    end

    it "increases backstage pass quality by 3 when sell_in < 5" do
      allow(pass_instance).to receive_messages(sell_in: 4, quality: 13)
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 13
    end

    it "decreases the quality to zero once sell_in < zero" do
      allow(pass_instance).to receive_messages(sell_in: -1, quality: 0)
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 0
    end

    it "cannot increase the quality of a backstage pass beyond 50" do
      allow(pass_instance).to receive_messages(sell_in: 6, quality: 50)
      gilded_rose.update_quality
      expect(gilded_rose.items[3].quality).to eq 50
    end
  end
end
