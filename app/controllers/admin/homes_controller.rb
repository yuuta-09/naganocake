class Admin::HomesController < ApplicationController
  before_action :authenticate_admin! # 管理者としてログインしなけらば使用できない
  before_action :define_orders, only: [:top]

  def top
  end

  private

  # urlにcustomer_idというパラメータがある場合は顧客ごとの注文履歴を表示
  # それ以外は注文を10件までを取得する
  def define_orders
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      @orders = customer.orders
    else
      @orders = Order.includes(:customer)
    end

    @orders = @orders.page(params[:page])
  end
end
