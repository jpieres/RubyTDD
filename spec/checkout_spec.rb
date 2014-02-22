require 'minitest/autorun'
require 'minitest/spec'
require_relative '../checkout'

describe Checkout do

  it "can create an instance of Checkout class" do
    co = Checkout.new
    co.must_be_instance_of Checkout
  end

  it "should respond to scan method" do
    co = Checkout.new
    co.must_respond_to :scan
  end

end