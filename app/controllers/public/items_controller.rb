class Public::ItemsController < ApplicationController
  before_action :define_active_item, only: [:show]
  before_action :define_genres

  def index
    items = get_active_items
    @items = items.page(params[:page]).per(8)
    @items_count = items.count
  end

  def show
    @item = Item.find(params[:id])
  end

  private
  def get_active_items
    if params[:item_kwg]
      items = Item.search_by_kwg(params[:item_kwg])
    elsif params[:genre_name]
      genre = Genre.find_by(name: params[:genre_name])
      items = genre.items
    else
      items = Item.all
    end

    return items.where(is_active: true)
  end

  def define_active_item
    @item = Item.find(params[:id])
    redirect_to items_path unless @item.is_active
  end

  def define_genres
    @genres = Genre.all
  end
end
