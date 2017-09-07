require_relative "item_helpers"

class AgedBrie
  include ItemHelpers
  attr_reader :sell_in, :quality

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def update_quality
    sell_in.negative? ? @quality += GildedRose::BASE_QUALITY_CHANGE * 2 : @quality += GildedRose::BASE_QUALITY_CHANGE
    quality_upper_boundary
  end
end

class BackstagePass
  include ItemHelpers
  attr_reader :sell_in, :quality
  QUALITY_FACTORS = {11 => 1, 6 => 2, 0 => 3}

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def update_quality
    if sell_in >= GildedRose::SELL_BY_DATE
      @quality += GildedRose::BASE_QUALITY_CHANGE * quality_factor
    else
      @quality = GildedRose::ITEM_QUALITY_MINIMUM
    end
    quality_upper_boundary
  end

  private

  def quality_factor
    QUALITY_FACTORS.select { |days_remaining, factor| days_remaining < sell_in }.values[0]
  end
end
