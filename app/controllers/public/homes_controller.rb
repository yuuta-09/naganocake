class Public::HomesController < ApplicationController
    # 顧客のトップページ
    def top
        @genres = Genre.all   # Genreテーブルのデータを取得
        @items = Item.take(4) # モデル.takeは指定した件数のレコードを取得する
    end

    # 顧客のサイト説明ページ
    def about
    end
end
