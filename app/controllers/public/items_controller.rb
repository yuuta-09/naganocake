class Public::ItemsController < ApplicationController
  def index
    if params[:item_kwg]
      items = Item.search_by_kwg(params[:item_kwg])
    else
      items = Item.all
    end
    @items = items.page(params[:page]).per(8)
    @items_count = items.count
  end

  def show
    @item = Item.find(params[:id])
  end
end
