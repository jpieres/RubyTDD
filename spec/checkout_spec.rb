require 'minitest/autorun'
require 'minitest/spec'
require_relative '../checkout'

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

  it "can be initialized with a pricing rule"
  
  describe "scan method" do
   it "can scan an item"
  end

  describe "total method" do
    it "should add all item's prices when there is no pricing rule"
    it "should apply pricing rule when given one"
  end

end