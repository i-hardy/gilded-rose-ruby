require_relative "gilded_rose"
require_relative "item_helpers"

class BackstagePass < Item
  include ItemHelpers
  attr_reader :sell_in, :quality
  QUALITY_FACTORS = {11 => 1, 6 => 2, 0 => 3}

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
