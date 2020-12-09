require 'minitest/autorun'
require 'minitest/pride'
require './lib/house'
require './lib/room'
class HouseTest < Minitest::Test

  def setup
    @house = House.new("$400000", "123 sugar lane")
    @room_1 = Room.new(:bedroom, 10, '13')
    @room_2 = Room.new(:bedroom, 11, '15')
    @room_3 = Room.new(:living_room, 25, '15')
    @room_4 = Room.new(:basement, 30, '41')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of House, @house
    assert_equal 400_000, @house.price
    assert_equal "123 sugar lane", @house.address
  end

  def test_rooms_is_empty_array
    assert_equal [], @house.rooms
  end

  def test_we_can_add_to_rooms
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    assert_equal [@room_1, @room_2], @house.rooms
  end

  def test_above_market_average
    house2 = House.new("$510000", "123 sugar lane")
    assert_equal false, @house.above_market_average?
    assert_equal true, house2.above_market_average?
  end

  def test_rooms_from_category
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)
    assert_equal [@room_1, @room_2], @house.rooms_from_category(:bedroom)
    assert_equal [@room_4], @house.rooms_from_category(:basement)
  end

  def test_house_area_method
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)
    assert_equal 1900, @house.area
  end

  def test_details_method_is_a_hash
    expected = { "price" => 400_000,
                 "address" => "123 sugar lane" }
    assert_equal expected, @house.details
  end

  def test_price_per_square_foot
    @house.add_room(@room_4)
    @house.add_room(@room_1)
    @house.add_room(@room_3)
    @house.add_room(@room_2)
    assert_equal 210.53, @house.price_per_square_foot
  end

  def test_sorted_by_area
    @house.add_room(@room_4)
    @house.add_room(@room_1)
    @house.add_room(@room_3)
    @house.add_room(@room_2)
    assert_equal [@room_4, @room_3, @room_2, @room_1], @house.rooms_sorted_by_area
  end

  def test_all_categories_helper
    @house.add_room(@room_4)
    @house.add_room(@room_1)
    @house.add_room(@room_3)
    @house.add_room(@room_2)
    assert_equal [:basement, :bedroom, :living_room], @house.all_categories
  end

  def test_rooms_by_category
    @house.add_room(@room_4)
    @house.add_room(@room_1)
    @house.add_room(@room_3)
    @house.add_room(@room_2)
    expected = {:bedroom => [@room_1, @room_2],
                :living_room => [@room_3],
                :basement => [@room_4]}
    assert_equal expected, @house.rooms_by_category
  end
end
