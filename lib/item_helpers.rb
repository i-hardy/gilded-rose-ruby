module ItemHelpers
  def decrease_sell_in
    @sell_in -= GildedRose::BASE_SELL_IN_CHANGE
  end

  def quality_upper_boundary
    @quality = GildedRose::ITEM_QUALITY_MAXIMUM unless @quality < GildedRose::ITEM_QUALITY_MAXIMUM
  end
end
