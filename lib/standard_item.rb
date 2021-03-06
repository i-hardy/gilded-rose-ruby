require_relative "gilded_rose"
require_relative "item_helpers"

class StandardItem < Item
  include ItemHelpers
  attr_reader :sell_in, :quality
  QUALITY_FACTOR = 2

  def update_quality
    @quality -= sell_in.negative? ?
      GildedRose::QUALITY_CHANGE * QUALITY_FACTOR : GildedRose::QUALITY_CHANGE
    quality_lower_boundary
  end
end
