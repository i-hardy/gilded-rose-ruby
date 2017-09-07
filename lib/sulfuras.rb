require_relative "gilded_rose"
require_relative "item_helpers"

class Sulfuras < Item
  attr_reader :sell_in, :quality

  def update_quality; end

  def decrease_sell_in; end
end
