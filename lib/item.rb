

class Item
  attr_reader :name, :price
  def initialize(product)
    @name = product[:name]
    @price = product[:price].gsub("$", "").to_f
  end
end
