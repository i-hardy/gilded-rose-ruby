require "item_helpers"

describe ItemHelpers do
  let(:item_class) { Class.new { include ItemHelpers } }
  let(:item) { item_class.new }

  before do
    item.instance_variable_set(:@sell_in, 10)
  end

  describe "#decrease_sell_in" do
    it "decreases the sell_in value" do
      expect { item.decrease_sell_in }
        .to change { item.instance_variable_get(:@sell_in) }
        .by(-GildedRose::SELL_IN_CHANGE)
    end
  end

  describe "#quality_upper_boundary" do
    it "decreases quality to the maximum if it is higher" do
      item.instance_variable_set(:@quality, 51)
      item.quality_upper_boundary
      expect(item.instance_variable_get(:@quality))
        .to eq GildedRose::QUALITY_MAXIMUM
    end
  end

  describe "#quality_lower_boundary" do
    it "increases quality to the minimum if it is higher" do
      item.instance_variable_set(:@quality, -1)
      item.quality_lower_boundary
      expect(item.instance_variable_get(:@quality))
        .to eq GildedRose::QUALITY_MINIMUM
    end
  end
end
