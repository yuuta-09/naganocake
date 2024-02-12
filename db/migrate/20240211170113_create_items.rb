# 商品テーブル
class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      # idは自動生成
      t.string  :name, null: false           # 商品名
      t.text    :introduction, null: false   # 商品説明
      t.integer :price, null: false          # 税抜き価格
      t.integer :genre_id, null: false       # ジャンルID リレーションを作るときに使用
      t.boolean :is_active, null: false      # 販売ステータス
      t.timestamps                           # 作成日時と更新日時
    end
  end
end
