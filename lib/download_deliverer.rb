require 'digest/sha1'

class DownloadDeliverer
  def initialize(order)
    @order = order
  end

  def deliver
    FetchAPI::Base.basic_auth(FETCH_KEY, FETCH_TOKEN)
    FetchAPI::Order.create(id: order_id, title: "Order from Hacker Engine", first_name: @order.first_name, 
                           last_name: @order.last_name, email: @order.email, order_items: [{ sku: FETCH_SKU }])
  end
  
  private 

  def order_id
    Digest::SHA1.hexdigest "#{@order.id}#{@order.email}"
  end
end
