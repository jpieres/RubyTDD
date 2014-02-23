class PricingRule

  attr_accessor :code, :condition, :action
  def initialize(args = {})
    @code = args[:code]
    @condition = args[:condition]
    @action = args[:action]
  end

end