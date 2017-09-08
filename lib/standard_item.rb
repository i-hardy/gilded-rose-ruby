require_relative "gilded_rose"
require_relative "item_helpers"

class StandardItem < Item
  include ItemHelpers
  attr_reader :sell_in, :quality

  def update_quality
    @quality -= sell_in.negative? ? GildedRose::QUALITY_CHANGE * 2 : GildedRose::QUALITY_CHANGE
    quality_lower_boundary
  end
end
