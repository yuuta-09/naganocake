class Admin::HomesController < ApplicationController
  def top
    @orders = Order.includes(:customer).includes(:order_details)
    @orders = @orders.page(params[:page])
  end
end
