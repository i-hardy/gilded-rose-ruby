class AgedBrie
  attr_reader :sell_in, :quality

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def decrease_sell_in
    @sell_in -= GildedRose::BASE_SELL_IN_CHANGE
  end

  def update_quality
    if quality < GildedRose::ITEM_QUALITY_MAXIMUM
      sell_in.negative? ? @quality += GildedRose::BASE_QUALITY_CHANGE * 2 : @quality += GildedRose::BASE_QUALITY_CHANGE
    end
  end
end

class BackstagePass
  attr_reader :sell_in, :quality
  QUALITY_FACTOR = {11 => 1, 6 => 2, 0 => 3}

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def decrease_sell_in
    @sell_in -= GildedRose::BASE_SELL_IN_CHANGE
  end

  def update_quality
    if quality < GildedRose::ITEM_QUALITY_MAXIMUM && sell_in >= 0
      @quality += GildedRose::BASE_QUALITY_CHANGE * quality_factor
    elsif sell_in.negative?
      @quality = GildedRose::ITEM_QUALITY_MINIMUM
    end
  end

  def quality_factor
    QUALITY_FACTOR.select { |key, value| key < sell_in }.values[0]
  end
end
