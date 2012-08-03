require 'spec_helper'

describe DownloadDeliverer do
  describe "#deliver" do
    before do
      stub_basic_auth
      stub_order_create
      DownloadDeliverer.new(Factory(:order)).deliver
    end

    it "performs basic authentication" do
      FetchAPI::Base.should have_received(:basic_auth).with(FETCH_KEY, FETCH_TOKEN)
    end
     
    it "creates on order" do
      FetchAPI::Order.should have_received(:create)
    end
  end

  def stub_basic_auth
    FetchAPI::Base.stubs(:basic_auth)
  end

  def stub_order_create
    FetchAPI::Order.stubs(:create)
  end
end
