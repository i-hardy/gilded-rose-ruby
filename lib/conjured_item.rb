require_relative "gilded_rose"

class ConjuredItem < Item
  include ItemHelpers
  attr_reader :sell_in, :quality
  QUALITY_FACTORS = [2, 4].freeze

  def update_quality
    @quality -= sell_in.negative? ?
      GildedRose::QUALITY_CHANGE * QUALITY_FACTORS[1] : GildedRose::QUALITY_CHANGE * QUALITY_FACTORS[0]
    quality_lower_boundary
  end
end
