class PricingRule
  # Attribute      code: Item code used to define the which elements will have their
  #                      prices updated.
  # Attribute condition: should be passed a Proc with a enumerable collection of objects
  #                      as parameter. Each object in the collection should respond to
  #                      messages code and price. Its return value is used to indicate
  #                      whether the condition on the collection elements is met
  #                      or not.
  # Attribute    action: should be passed a Proc with a enumerable collection of objects
  #                      as parameter. Each object in the collection should respond to
  #                      messages code and price. If the condition is met, the action will 
  #                      update the prices in the collection with the criteria defined in
  #                      the Proc.
  
  attr_accessor :code, :condition, :action
  def initialize(args = {})
    @code = args[:code]
    @condition = args[:condition]
    @action = args[:action]
  end

end