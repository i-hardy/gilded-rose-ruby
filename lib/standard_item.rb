require_relative "gilded_rose"
require_relative "item_helpers"

class StandardItem < Item
  include ItemHelpers
  attr_reader :sell_in, :quality

  def update_quality
    sell_in.negative? ? @quality -= GildedRose::BASE_QUALITY_CHANGE * 2 : @quality -= GildedRose::BASE_QUALITY_CHANGE
  end
end
