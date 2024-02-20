class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total_payment = CartItem.get_total_payment(@cart_items)
  end

  def create
    @cart_item = CartItem.new_or_add(cart_item_params, current_customer)
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(cart_item_params[:item_id])
      render "public/items/show"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = current_customer.cart_items
    @total_payment = CartItem.get_total_payment(@cart_items)

    # 保存に成功してもしなくてもindexページに移動
    render :index
  end

  def destroy
    CartItem.find(params[:id]).destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end