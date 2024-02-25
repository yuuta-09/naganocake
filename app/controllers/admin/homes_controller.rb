class Admin::HomesController < ApplicationController
  before_action :authenticate_admin! # 管理者としてログインしなけらば使用できない
  def top
    @orders = Order.includes(:customer)
    @orders = @orders.page(params[:page])
  end
end
