class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!  # 全てのアクションが顧客としてのログインが必要

  def index
    @cart_items = current_customer.cart_items                 # 現在ログイン中のユーザのカート商品をすべて取得
    @total_payment = CartItem.get_total_payment(@cart_items)  # @cart_itemsに入った商品すべての金額の合計を計算
  end

  def create
    @cart_item = CartItem.new_or_add(cart_item_params, current_customer)  # 既にカートに入っている場合は個数の追加、まだ存在しない場合は新たに作成
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(cart_item_params[:item_id]) # render先で使用する商品が入った変数
      render "public/items/show"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id]) # urlの:idからcart_itemを取得
    if @cart_item.update(cart_item_params)      
      redirect_to cart_items_path           # urlがずれないようにredirect_to
    else
      @cart_items = current_customer.cart_items                # render先で使用するカート内商品一覧
      @total_payment = CartItem.get_total_payment(@cart_items) # render先で使用する@cart_itemに入った商品すべての金額の合計値
      render :index                                            # フォームやエラーが消えないようにrender
    end
  end

  def destroy
    CartItem.find(params[:id]).destroy # urlの:idから取得したcart_itemを削除
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    # フォームから送られてくるcart_itemの内容で許可する値を定義
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
