require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/pricing_rule'

describe PricingRule do

  before do
    @pr = PricingRule.new
  end

  it "can create an instance of PricingRule class" do
    @pr.must_be_instance_of PricingRule
  end

  it "can be initialized from a hash of data" do
    pr = PricingRule.new code: 'GR1', condition: 'a_condition', action: 'an_action'
    pr.must_be_instance_of PricingRule
  end

  it "should respond to code with the initialized code" do
    pr = PricingRule.new code: 'GR1', condition: 'a_condition', action: 'an_action'
    pr.code.must_equal 'GR1'
  end

  it "should respond to condition with the initialized condition" do
    condition = 'a_condition'
    pr = PricingRule.new code: 'GR1', condition: condition, action: 'an_action'
    pr.condition.must_equal condition
  end

  it "should respond to action with the initialized action" do
    action = 'an_action'
    pr = PricingRule.new code: 'GR1', condition: 'a_condition', action: action
    pr.action.must_equal action
  end

  # TODO add more specs to test and document :condition and :action attributes
  # Attribute condition: should be passed a Proc with a enumerable collection of objects
  #                      as parameter. Each object in the collection should respond to
  #                      messages code and price.
  # Attribute    action: should be passed a Proc with a enumerable collection of objects
  #                      as parameter. Each object in the collection should respond to
  #                      messages code and price.

end