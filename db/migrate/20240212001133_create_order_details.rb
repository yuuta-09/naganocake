# 注文詳細テーブル
class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      # idは自動生成
      t.integer :price, null: false                     # 購入時価格
      t.integer :amount, null: false                    # 数量
      t.integer :making_status, null: false, default: 0 # 製造ステータス enumで管理{0: 製作不可, 1: 制作待ち, 2: 製作中, 3: 製作完了}
      t.integer :order_id, null: false                  # 注文ID リレーションに使用
      t.integer :item_id, null: false                   # 商品ID リレーションに使用
      t.timestamps                                      # 作成日時と更新日時
    end
  end
end
