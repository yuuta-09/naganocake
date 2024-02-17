class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!                   # 管理者ログイン済みの場合のみ商品の機能を使用できる
  before_action :define_genres, only: [:new, :create]  # 予め全てのGenreを取得
  
  def index
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def show
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :genre_id, :is_active)
  end

  def define_genres
    @genres = Genre.all
  end
end
