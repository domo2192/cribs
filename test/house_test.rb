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
    assert_equal 400000, @house.price
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
    assert_equal false, @house.above_market_average?
  end

  def test_rooms_from_category
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)
    assert_equal [@room_1, @room_2], @house.rooms_from_category(:bedroom)
  end

  def test_house_area_method
    @house.add_room(@room_1)
    @house.add_room(@room_2)
    @house.add_room(@room_3)
    @house.add_room(@room_4)
    assert_equal 1900, @house.area
  end

  def test_details_method_is_a_hash
    expected = {"price" => 400_000,
                "address" => "123 sugar lane"}
  assert_equal expected, @house.details 
  end
end
