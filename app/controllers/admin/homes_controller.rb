class Admin::HomesController < ApplicationController
  def top
    @orders = Order.includes(:customer)
    @orders = @orders.page(params[:page])
  end
end
