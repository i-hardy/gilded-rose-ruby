class GildedRose
  SPECIAL_ITEM_NAMES = ["Aged Brie", "Sulfuras, Hand of Ragnaros", "Backstage passes to a TAFKAL80ETC concert"]
  BASE_QUALITY_CHANGE = 1
  BASE_SELL_IN_CHANGE = 1
  ITEM_QUALITY_MINIMUM = 0
  ITEM_QUALITY_MAXIMUM = 50
  SELL_BY_DATE = 0

  attr_reader :items, :special_items, :item_classes

  def initialize(items, brie_class: AgedBrie, pass_class: BackstagePass)
    @items = items
    @special_items = []
    @item_classes = {"Aged Brie" => brie_class,
                     "Backstage passes to a TAFKAL80ETC concert" => pass_class}
    create_special_items
  end

  def create_special_items
    items.each do |item|
      if item_classes[item.name]
        special_items << item_classes[item.name].new(item.name, item.sell_in, item.quality)
        items.delete(item)
      end
    end
  end

  def decrease_item_sell_in
    items.each do |item|
      unless item.name == "Sulfuras, Hand of Ragnaros"
        item.sell_in -= BASE_SELL_IN_CHANGE
      end
    end
  end

  def special_items_update
    special_items.each do |item|
      item.update_quality
      item.decrease_sell_in
    end
  end

  def standard_item_quality
    items.each do |item|
      unless SPECIAL_ITEM_NAMES.include?(item.name) || item.quality == ITEM_QUALITY_MINIMUM
        item.sell_in >= SELL_BY_DATE ? item.quality -= BASE_QUALITY_CHANGE : item.quality -= BASE_QUALITY_CHANGE * 2
      end
    end
  end

  def update_quality()
    decrease_item_sell_in
    standard_item_quality
    special_items_update
  end
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
