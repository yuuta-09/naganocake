class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!                             # 注文機能の機能は顧客としてのログインが必要
  before_action :cart_item_exists?, only: [:new, :confirm, :create]

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  # 注文情報確定画面
  def confirm
    @order = Order.new(order_params)
    @order.customer = current_customer
    @cart_items = current_customer.cart_items
    @total_payment = CartItem.get_total_payment(@cart_items)
    @shipping_cost = Order.shipping_cost

    @order.set_address(params[:order])
  end

  # 注文完了画面
  def thanks
  end

  def index
    @orders = current_customer.orders.includes(order_details: :item) # N + 1問題を解決するために関連する情報を一度に取得
    @orders = @orders.page(params[:page]).per(5)                     # 取得したorderモデルを5件分のみに制限する。
  end

  def show
    @order = current_customer.orders.find(params[:id])   # ログイン中のユーザが投稿したもののみから注文を探す
    @order_details = @order.order_details.includes(:item) # N + 1問題を解決するために関連モデルも同時に取得
  end

  # 注文確定処理
  def create
    @order = Order.new(order_params)
    @order.customer = current_customer
    @order.shipping_cost = Order.shipping_cost
    @order.total_payment = params[:order][:total_payment]

    if @order.save
      @order.create_order_details(current_customer.cart_items)
      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  private

  def order_params
    # フォームから送信されるorderに関する情報で保存の際に許可する値を定義
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

  # カートに商品が入っていない場合はカート一覧ページへ遷移
  def cart_item_exists?
    unless current_customer.cart_items.present?
      redirect_to cart_items_path, notice: "カートに商品が入っていません。"
    end
  end
end
