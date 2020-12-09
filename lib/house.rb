class House
  attr_reader:price,
             :address,
             :rooms
  def initialize(price, address)
    @price = price.delete("$").to_i
    @address = address
    @rooms = []
  end

  def add_room(room)
    @rooms << room
  end

  def above_market_average?
    @price > 500_000
  end

  def rooms_from_category(category)
    @rooms.find_all do |room|
      room.category == category
    end
  end

  def area
    @rooms.sum do |room|
      room.area
    end
  end

  def details
    dets = {"price" => @price , "address" => @address}
  end

  def price_per_square_foot
    (@price.to_f / area).round(2)
  end

  def rooms_sorted_by_area
    @rooms.sort_by do |room|
      -room.area
    end
  end

  def all_categories
    all_categories = []
      @rooms.each do |room|
      all_categories << room.category
    end
    all_categories.uniq!
  end

  def rooms_by_category
    breakdown = {}
      all_categories.each do |category|
      breakdown[category] = rooms_from_category(category)
    end
    breakdown 
  end
end
