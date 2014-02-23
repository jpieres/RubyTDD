class Checkout
  
  attr_accessor :items, :pricing_rules
  def initialize(pricing_rules = [])
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    items = @items
    @pricing_rules.each do |pricing_rule|
      pricing_rule.action.call(items) if pricing_rule.condition.call(items)
    end
    sum = @items.inject(0) {|sum, item| sum + item.price}  
  end 
end
