class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!                               # 管理者ログイン済みの場合のみ商品の機能を使用できる
  before_action :define_genres,      only: [:new, :edit]           # 予め全てのGenreを定義
  before_action :define_item_by_id,  only: [:show, :edit, :update] # 予めparameteに基づきitemを定義
  
  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
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
      define_genres
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      define_genres
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :genre_id, :is_active)
  end

  def define_genres
    @genres = Genre.all
  end

  def define_item_by_id
    @item = Item.find(params[:id])
  end
end
