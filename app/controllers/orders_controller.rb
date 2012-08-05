class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])

    if @order.save_with_payment
      # To enable digital download delivery, uncomment the line below and see lib/download_deliverer.rb
       DownloadDeliverer.deliver_download

      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def add_collaborator
    CollaboratorAdder.add(@order.github_username)
  end

  def deliver_download
    DownloadDeliverer.new(@order).deliver
  end
  
  
end
