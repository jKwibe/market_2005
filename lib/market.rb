

class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors =[]
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.select {|vendor| vendor.inventory.include?(item)}
  end

  def total_inventory

    all_items = @vendors.flat_map do |ven|
      ven.inventory.keys
    end.uniq
hash ={}
    all_items.each do |it|
      @vendors.each do |vendor|
        s =  @vendors.select{|vendor| vendor.inventory.include?(it)}.map{|ve| ve.inventory}
        total = 0
        s.each do  |f|
          f.each do |k, v|
            total += v if k == it
          end
        end
        hash[it] = {
          quantity: total,
          vendors: @vendors.select{|vendor| vendor.inventory.include?(it)}
        }
      end
    end
 hash
  end

  def overstocked_items
    total_inventory.filter_map do |k, v|
       k if v[:vendors].size > 1 && v[:quantity] > 50
    end
  end

  def sorted_item_list
    all_items = @vendors.flat_map do |ven|
      ven.inventory.keys
    end.uniq

    all_items.map{|it| it.name}.sort
  end
end
