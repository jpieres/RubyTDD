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

    describe "fulfills all test data scenarios" do
      before do 
        @pricing_rule1 = PricingRule.new code: 'GR1',
          condition: Proc.new { |items| items.count {|item| item.code == 'GR1'} >= 2 },
          action: Proc.new { |items| items.find_all{ |item| item.code == 'GR1' }.each_with_index { |item, i| item.price = 0 if i.odd? } }
        @pricing_rule2 = PricingRule.new code: 'SR1',
          condition: Proc.new { |items| items.count { |item| item.code == 'SR1'} >= 3 },
          action: Proc.new { |items| items.each { |item| item.price = 4.5 if item.code == 'SR1'}}
        
        @item1 = OpenStruct.new code: 'GR1', name: 'Green Tea', price: 3.11
        @item2 = OpenStruct.new code: 'SR1', name: 'Strawberries', price: 5.00
        @item3 = OpenStruct.new code: 'CF1', name: 'Coffe', price: 11.23 
      end

      it "should apply pricing rule buy-one-get-one-free" do
        items =  [@item1, @item1.clone, @item1.clone]
        @co.pricing_rules = [@pricing_rule1]
        items.each { |item| @co.scan item }
        @co.total.must_equal 3.11*2
      end

      it "should apply pricing rule discount prices based on item count" do
        items =  [@item2, @item2.clone, @item2.clone]
        co = Checkout.new([@pricing_rule2])
        items.each { |item| co.scan item }
        co.total.must_equal 4.5*3
      end


      it "should fulfill test data scenario 1" do
        items =  [@item1, @item2, @item1.clone, @item1.clone, @item3]
        co = Checkout.new([@pricing_rule1, @pricing_rule2])
        items.each { |item| co.scan item }
        co.total.must_equal 22.45
      end

      it "should fulfill test data scenario 2" do
        items =  [@item1, @item1.clone]
        co = Checkout.new([@pricing_rule1, @pricing_rule2])
        items.each { |item| co.scan item }
        co.total.must_equal 3.11
      end

      it "should fulfill test data scenario 3" do
        items =  [@item2, @item2.clone, @item1, @item2.clone]
        co = Checkout.new([@pricing_rule1, @pricing_rule2])
        items.each { |item| co.scan item }
        co.total.must_equal 16.61
      end
    end
  end
end