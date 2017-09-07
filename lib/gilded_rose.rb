class GildedRose
  SPECIAL_ITEMS = ["Aged Brie", "Sulfuras, Hand of Ragnaros", "Backstage passes to a TAFKAL80ETC concert"]
  BASE_QUALITY_CHANGE = 1
  BASE_SELL_IN_CHANGE = 1
  ITEM_QUALITY_MINIMUM = 0
  ITEM_QUALITY_MAXIMUM = 50

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def decrease_item_sell_in
    items.each do |item|
      unless item.name == "Sulfuras, Hand of Ragnaros"
        item.sell_in -= BASE_SELL_IN_CHANGE
      end
    end
  end

  def standard_item_quality
    items.each do |item|
      unless SPECIAL_ITEMS.include?(item.name) || item.quality == ITEM_QUALITY_MINIMUM
        item.sell_in >= 0 ? item.quality -= BASE_QUALITY_CHANGE : item.quality -= BASE_QUALITY_CHANGE * 2
      end
    end
  end

  def aged_brie_quality
    items.each do |item|
      if item.name == "Aged Brie" && item.quality < ITEM_QUALITY_MAXIMUM
        item.sell_in >= 0 ? item.quality += BASE_QUALITY_CHANGE : item.quality += BASE_QUALITY_CHANGE * 2
      end
    end
  end

  def backstage_pass_quality
    items.each do |item|
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        if item.quality < ITEM_QUALITY_MAXIMUM && item.sell_in >= 0
          if item.sell_in > 10
            item.quality += BASE_QUALITY_CHANGE
          elsif item.sell_in > 5
            item.quality += BASE_QUALITY_CHANGE * 2
          else
            item.quality += BASE_QUALITY_CHANGE * 3
          end
        elsif item.sell_in < 0
          item.quality = 0
        end
      end
    end
  end

  def update_quality()
    decrease_item_sell_in
    standard_item_quality
    aged_brie_quality
    backstage_pass_quality
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
