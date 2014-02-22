require 'minitest/autorun'
require 'minitest/spec'
require_relative '../checkout'
require_relative '../lib/pricing_rule'

describe Checkout do

  before do
    @co = Checkout.new
  end


  it "can create an instance of Checkout class" do
    @co.must_be_instance_of Checkout
  end

  it "should respond to scan method" do
    @co.must_respond_to :scan
  end

  it "should respond_to total method" do
    @co.must_respond_to :total
  end

  it "defaults total to zero" do
    @co.total.must_equal 0
  end

  it "can be initialized with a pricing rule array" do
    pr = PricingRule.new(code: 'GR1', rule: 'A rule')
    co = Checkout.new([pr, pr])
    co.must_be_instance_of Checkout
  end
  
  describe "scan method" do
    it "can scan an item" do
      @co.scan(Object.new)
    end
  end

  describe "total method" do
    it "should add all item's prices when there is no pricing rule" do
      item1 = Minitest::Mock.new
      item1.expect :price, 3.11
      @co.scan(item1)
      item2 = Minitest::Mock.new
      item2.expect :price, 5.00
      @co.scan(item2)
      @co.total.must_equal 8.11
      item1.verify
      item2.verify
    end

    it "should apply pricing rules when given"
  end

end