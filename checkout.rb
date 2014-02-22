class Checkout
  
  def initialize(pricing_rules = nil)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    @items.inject(0) {|sum, element| sum + element.price}
  end
  
end
