require 'spec_helper'

describe "#save_with_payment" do
  let(:order) { Factory.build(:order)}

  context "when the model is valid" do
    context "when stripe billing succeeds" do
      it "saves a new order" do
        stub_stripe
        order.save_with_payment
        Order.count.should == 1
      end
    end

    context "when stripe billing fails" do
      it "does not save a new order" do
        stub_stripe_to_raise_exception
        order.save_with_payment
        Order.count.should == 0
      end
    end
  end

  context "when the model is invalid" do
    it "does not try to create a customer" do
      stub_order_to_be_invalid
      order.save_with_payment
      Stripe::Charge.should have_received(:create).never
    end

    it "does not save the order" do
      stub_order_to_be_invalid
      order.save_with_payment
      order.should_not be_persisted
    end
  end

  def stub_stripe
    Stripe::Charge.stubs(:create).returns(stub('customer', id: '1'))
  end

  def stub_stripe_to_raise_exception
    Stripe::Charge.stubs(:create).raises(Stripe::InvalidRequestError.new('error message', 'param'))
  end

  def stub_order_to_be_invalid
    order.stubs(:valid?).returns(false)
  end
end
