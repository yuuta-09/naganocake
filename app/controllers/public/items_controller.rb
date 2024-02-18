class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @items_count = Item.all.count
  end

  def show
  end
end
