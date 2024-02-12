# カート内アイテムテーブル
class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      # idは自動生成
      t.integer :amount, null: false       # 数量
      t.integer :item_id, null: false      # 商品ID リレーションを作るときに使用
      t.integer :customer_id, null: false  # 会員ID リレーションを作るときに使用
      t.timestamps
    end
  end
end
