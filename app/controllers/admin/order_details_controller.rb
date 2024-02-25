class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin! # 管理者としてのログインが必要

  def update
    order_detail = OrderDetail.find(params[:id])
    @order = order_detail.order
    @order_details = @order.order_details
    unless order_detail.update(order_detail_params)
      flash[:alert] = '製作ステータスの更新に失敗しました。'
      return render 'admin/orders/show'
    end

    if @order_details.all? { |m| m.making_status == 'production_complete' }
      @order.update(status: "preparing_to_ship")
    end

    redirect_to admin_order_path(@order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
