class Public::ItemsController < ApplicationController
  before_action :define_active_item, only: [:show]  # 販売中の商品を一つ取得する
  before_action :define_genres                      # ジャンル全てを取得する

  def index
    items = get_active_items                  # 販売中の商品すべてを取得する
    @items = items.page(params[:page]).per(8) # kaminariで8件分だけ取得する
    @items_count = items.count                # 商品の数をカウントする
  end

  def show
    @item = Item.find(params[:id])  # urlの:idをもとにItemを1つ取得する
    @cart_item = CartItem.new       # 新規作成するのにフォームで使う変数
  end

  private
  # いくつかの条件に基づいて販売中の商品をすべて取得する
  # 1. 検索で:item_kwgが渡されたら部分一致で検索
  # 2. ジャンルが選択されていたらgenre_nameで検索
  def get_active_items
    if params[:item_kwg]
      items = Item.search_by_kwg(params[:item_kwg])
    elsif params[:genre_name]
      genre = Genre.find_by(name: params[:genre_name])
      items = genre.items
    else
      items = Item.all
    end

    return items.where(is_active: true).with_attached_image
  end

  # 販売中の商品を１つ取得し、インスタンス変数(@item)に格納する
  def define_active_item
    @item = Item.find(params[:id])
    redirect_to items_path unless @item.is_active
  end

  # ジャンルすべてを取得し、インスタンス変数(@items)に格納
  def define_genres
    @genres = Genre.all
  end
end
