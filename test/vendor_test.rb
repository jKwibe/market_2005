require "minitest/autorun"
require './lib/item'
require './lib/vendor'

class ItemTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exist
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
  end

  def test_it_has_an_inventory
    expected = {}
    assert_equal expected, @vendor.inventory
  end

  def test_it_can_check_stock
    assert_equal 0, @vendor.check_stock(@item1)
  end

  def test_it_can_stock
    @vendor.stock(@item1, 30)
    assert_equal 30, @vendor.check_stock(@item1)
    @vendor.stock(@item1, 25)
    assert_equal 55, @vendor.check_stock(@item1)
    @vendor.stock(@item2, 12)
    assert_equal 12, @vendor.check_stock(@item2)

    expected = {
      @item1 => 55,
      @item2 => 12
    }

    assert_equal expected, @vendor.inventory
  end
end
