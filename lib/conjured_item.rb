require_relative "gilded_rose"

class ConjuredItem < Item
  include ItemHelpers
  attr_reader :sell_in, :quality

  def update_quality
    @quality -= sell_in.negative? ? GildedRose::QUALITY_CHANGE * 4 : GildedRose::QUALITY_CHANGE * 2
    quality_lower_boundary
  end
end
