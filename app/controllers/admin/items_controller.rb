class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!                               # 管理者ログイン済みの場合のみ商品の機能を使用できる
  before_action :define_genres,      only: [:new, :edit]           # 予め全てのGenreを定義
  before_action :define_item_by_id,  only: [:show, :edit, :update] # 予めparameteに基づきitemを定義
  
  def index
    # kaminariで、表示件数を制御しながらitem一覧を取得
    @items = get_items.page(params[:page])
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
      redirect_to admin_item_path(@item.id)
    else
      define_genres
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      define_genres # renderした後のページで使用するためのインスタンス変数を定義
      render :edit
    end
  end

  private

  def item_params
    # フォームからitemのデータ送信を許可をしていい値を定義
    params.require(:item).permit(:image, :name, :introduction, :price, :genre_id, :is_active)
  end

  # 全てのGenreを取得
  def define_genres
    @genres = Genre.all
  end

  # urlの:idに基づき1つのGenreを取得
  def define_item_by_id
    @item = Item.find(params[:id])
  end

  # Item全てのモデルを取得
  # 検索機能でitem_kwgが設定されていた場合はキーワードに一致するものを取得
  def get_items
    if params[:item_kwg]
      items = Item.search_by_kwg(params[:item_kwg])
    else
      items = Item.all
    end

    return items
  end
end
