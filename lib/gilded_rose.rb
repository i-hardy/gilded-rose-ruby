class GildedRose
  QUALITY_CHANGE = 1
  SELL_IN_CHANGE = 1
  QUALITY_MINIMUM = 0
  QUALITY_MAXIMUM = 50

  attr_reader :items

  def initialize(items,
                 standard_class: StandardItem,
                 brie_class: AgedBrie,
                 sulfuras_class: Sulfuras,
                 pass_class: BackstagePass,
                 conjured_class: ConjuredItem)
    @items = items
    @classified_items = []
    @item_classes = { "Standard" => standard_class,
                      "Aged Brie" => brie_class,
                      "Sulfuras, Hand of Ragnaros" => sulfuras_class,
                      "Backstage passes to a TAFKAL80ETC concert" => pass_class,
                      "Conjured item" => conjured_class }
    create_classified_items
  end

  def create_classified_items
    items.each do |item|
      classified_items << get_item_class(item.name).new(item.name, item.sell_in, item.quality)
    end
  end

  def classified_items_update
    classified_items.each do |classified_item|
      classified_item.update_quality
      classified_item.decrease_sell_in
    end
  end

  def update_items_list
    items.each_with_index do |item, index|
      item.sell_in = classified_items[index].sell_in
      item.quality = classified_items[index].quality
    end
  end

  def update_quality
    classified_items_update
    update_items_list
  end

  def get_item_class(name)
    item_classes[name] || item_classes["Standard"]
  end

  private

  attr_reader :classified_items, :item_classes
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
