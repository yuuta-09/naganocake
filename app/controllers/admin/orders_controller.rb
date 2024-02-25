class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin! # 管理者としてのログインをしていないと使用できない

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == 'confirm'
        update_making_status(@order)
      end
      redirect_to admin_order_path(@order.id)
    else
      @order_details = @order.order_details.includes(:item)
      flash[:alert] = "注文ステータスの更新に失敗しました。"
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def update_making_status(order_model)
    order_details = order_model.order_details
    for order_detail in order_details
      order_detail.update(making_status: 'waiting_for_production')
    end
  end
end
