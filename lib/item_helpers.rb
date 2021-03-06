module ItemHelpers
  def decrease_sell_in
    @sell_in -= GildedRose::SELL_IN_CHANGE
  end

  def quality_upper_boundary
    @quality = GildedRose::QUALITY_MAXIMUM unless @quality < GildedRose::QUALITY_MAXIMUM
  end

  def quality_lower_boundary
    @quality = GildedRose::QUALITY_MINIMUM unless @quality > GildedRose::QUALITY_MINIMUM
  end
end
