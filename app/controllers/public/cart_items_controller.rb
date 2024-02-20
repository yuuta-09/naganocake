class Public::CartItemsController < ApplicationController
  def index
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer = current_customer
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(cart_item_params[:item_id])
      render "public/items/show"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
