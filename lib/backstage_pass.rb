require_relative "gilded_rose"
require_relative "item_helpers"

class BackstagePass < Item
  include ItemHelpers
  attr_reader :sell_in, :quality
  QUALITY_FACTORS = { 11 => 1, 6 => 2, 0 => 3 }.freeze

  def update_quality
    @quality += sell_in.negative? ? -quality : GildedRose::QUALITY_CHANGE * quality_factor
    quality_upper_boundary
  end

  private

  def quality_factor
    QUALITY_FACTORS.select { |days_remaining, _factor| days_remaining < sell_in }.values[0]
  end
end
